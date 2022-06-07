//
//  HTTPRequestDelegate.m
//  blockchyp-ios
//

#import "HTTPRequestDelegate.h"
#import "EncodingUtils.h"
#import "NSData+FastHex.h"

@implementation HTTPRequestDelegate

BlockChypClient *client;

-(id)initWithClient:(BlockChypClient *)clientInstance {
    
    self = [self init];
    client = clientInstance;
    return self;
}

-(NSString *)resolveGatewayURLFor:(NSString *)path test:(bool)test {
    
    NSString *url = [[NSString alloc] init];
    
    if (test) {
        url = [url stringByAppendingString:client.testGatewayHost];
    } else {
        url = [url stringByAppendingString:client.gatewayHost];
    }
    
    return [url stringByAppendingString:path];
    
}

-(NSString *)resolveDashboardURLFor:(NSString *)path {
    
    NSString *url = [[NSString alloc] initWithString:client.dashboardHost];
    
    return [url stringByAppendingString:path];
    
}

-(NSString *)resolveTerminalURLFor:(NSDictionary *)route path:(NSString *)path {
    
    NSString *url = [[NSString alloc] init];
     
    NSString *ipAddress = (NSString *)[route objectForKey:@"ipAddress"];
    
    if (client.https) {
        url = [url stringByAppendingString:@"https://"];
    } else {
        url = [url stringByAppendingString:@"http://"];
    }
    url = [url stringByAppendingString:ipAddress];
    if (client.https) {
        url = [url stringByAppendingString:@":8443"];
    } else {
        url = [url stringByAppendingString:@":8080"];
    }
    url = [url stringByAppendingString:path];
    
    return url;
    
}

-(NSString *)generateNonceWithSize:(int)size {
    
    NSMutableData *data = [NSMutableData dataWithCapacity:size];
    for( unsigned int i = 0 ; i < size/4 ; ++i )
    {
      u_int32_t randomBits = arc4random();
      [data appendBytes:(void*)&randomBits length:4];
    }
    NSData *immutableData = [[NSData alloc] initWithBytes:[data bytes] length:[data length]];
    return [immutableData hexStringRepresentation];
    
}

-(NSString *)generateTimestamp {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    return[formatter stringFromDate:now];
    
}

-(NSDictionary *)generateGatewayHeaders {
    
    NSString *nonce = [self generateNonceWithSize:32];
    NSString *ts = [self generateTimestamp];
     
    NSString *auth = [NSString stringWithFormat:@"Dual %@:%@", client.bearerToken, client.apiKey];
    
    NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
    [headers setValue:nonce forKey:@"Nonce"];
    [headers setValue:ts forKey:@"Timestamp"];
    [headers setValue:auth forKey:@"Authorization"];
    
    
    return headers;
}

-(void)gatewayGetWithPath:(NSString *)path test:(BOOL)test handler:(BlockChypGetCompletionHandler)handler {
    
    self.getHandler = handler;
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSLog(@"GET: %@", path);
    
    NSDictionary *headers = [self generateGatewayHeaders];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest addValue:[headers valueForKey:@"Nonce"] forHTTPHeaderField:@"Nonce"];
    [urlRequest addValue:[headers valueForKey:@"Timestamp"] forHTTPHeaderField:@"Timestamp"];
    [urlRequest addValue:[headers valueForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *downloadTask = [session
    dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *urlResponse, NSError *error) {
        
        NSDictionary *response = [[NSDictionary alloc] init];
        
        if (error == nil) {
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            response = [EncodingUtils parseJSON:json];;
        }
    
        self.getHandler(response, error);
    }];
    
    [downloadTask resume];
    
}

-(void)routeTerminalRequestWith:(NSDictionary *)request terminalPath:(NSString *)terminalPath gatewayPath:(NSString *)gatewayPath method:(NSString *)method handler:(BlockChypCompletionHandler)handler {
    
    self.handler = handler;
    
    NSString *terminalName = [request objectForKey:@"terminalName"];
    
    NSString *routePath = [NSString stringWithFormat:@"%@%@", @"/api/terminal-route?terminal=", [terminalName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
    
    NSString *url = [self resolveGatewayURLFor:routePath test:NO];
    
    NSLog(@"GET: %@", url);
    
    [self gatewayGetWithPath:url test:false handler:^(NSDictionary * response, NSError * error) {
        
        if (error != nil) {
            self.handler(request, [[NSDictionary alloc] init], error);
            return;
        }
        
        if (response == nil) {
            self.handler(request, [[NSDictionary alloc] init], nil);
            return;
        }
        
        //update cache asyncronously
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            [self updateCacheWith:response];
        });
        
        [self routeCachedTerminalRequestWith:request route:response terminalPath:terminalPath gatewayPath:gatewayPath method:method handler:handler];

    }];
    
}

-(void)updateCacheWith:(NSDictionary *)route {
    
    NSString *terminalName = [route objectForKey:@"terminalName"];
    NSString *routeKey = [NSString stringWithFormat:@"%@%@", client.apiKey, terminalName];
    
    NSMutableDictionary *routeEntry = [[NSMutableDictionary alloc] init];
    [routeEntry setObject:route forKey:@"route"];
    
    NSDate * now = [NSDate date];
    NSDate *ttl = [now dateByAddingTimeInterval:(client.routeCacheTTL*60)];
    [routeEntry setObject:ttl forKey:@"ttl"];
    
    [client.routeCache setObject:routeEntry forKey:routeKey];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *pathForFile = @".blockchyp_routes";

    //assume no cache
    NSMutableDictionary *offlineCache = [[NSMutableDictionary alloc] init];
    
    if ([fileManager fileExistsAtPath:pathForFile]){
                    NSData *jsonData = [NSData dataWithContentsOfFile:pathForFile];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        offlineCache = [NSMutableDictionary dictionaryWithDictionary:[EncodingUtils parseJSON:json]];
    }
    
    [offlineCache setObject:route forKey:routeKey];
    
    NSError *error;
    NSData *jsonBody = [NSJSONSerialization dataWithJSONObject:offlineCache options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"error saving offline cache");
        return;
    }
    
    [jsonBody writeToFile:pathForFile options:NSDataWritingAtomic error:&error];
    
}

-(void)routeCachedTerminalRequestWith:(NSDictionary *)request route:(NSDictionary *)route terminalPath:(NSString *)terminalPath gatewayPath:(NSString *)gatewayPath method:(NSString *)method handler:(BlockChypCompletionHandler)handler {

    NSLog(@"Route State: ...");
    [self logDictionary:route];
    
    NSNumber *cloudRelay = (NSNumber *)[route objectForKey:@"cloudRelayEnabled"];
    
    if ( (cloudRelay != nil) && cloudRelay.boolValue) {
        [self routeGatewayRequestWith:request path:gatewayPath method:method handler:handler];
        return;
    }
    
    NSString *url = [self resolveTerminalURLFor:route path:terminalPath];
    
    NSLog(@"TERMINAL GET: %@", url);
    
    NSDictionary *txCreds = [route objectForKey:@"transientCredentials"];
    
    NSMutableDictionary *terminalRequest = [NSMutableDictionary dictionaryWithDictionary:txCreds];
    terminalRequest[@"request"] = request;
    
    NSError *error;
    NSData *jsonBody = [NSJSONSerialization dataWithJSONObject:terminalRequest options:0 error:&error];
    
    if (error != nil) {
        self.handler(request, [[NSDictionary alloc] init], error);
        return;
    }
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest new];
    urlRequest.HTTPMethod = method;
    [urlRequest setURL:[NSURL URLWithString:url]];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setHTTPBody:jsonBody];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *downloadTask = [session
    dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *urlResponse, NSError *error) {
       
       NSDictionary *response = [[NSDictionary alloc] init];
       
       if (error == nil) {
           NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           response = [EncodingUtils parseJSON:json];;
       } else {
           [self evictFromRouteCache:route];
       }
   
       self.handler(request, response, error);
   }];
       
    [downloadTask resume];
   
}

-(void) evictFromRouteCache:(NSDictionary *)route {
    
    NSLog(@"evicting from cache");
    
    NSString *terminalName = [route objectForKey:@"terminalName"];
    
    NSString *routeKey = [NSString stringWithFormat:@"%@%@", client.apiKey, terminalName];
    
    [client.routeCache removeObjectForKey:routeKey];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *pathForFile = @".blockchyp_routes";

    //assume no cache
    NSMutableDictionary *offlineCache = [[NSMutableDictionary alloc] init];
    
    if ([fileManager fileExistsAtPath:pathForFile]){
                    NSData *jsonData = [NSData dataWithContentsOfFile:pathForFile];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        offlineCache = [NSMutableDictionary dictionaryWithDictionary:[EncodingUtils parseJSON:json]];
        [offlineCache removeObjectForKey:routeKey];
        NSError *error;
        NSData *jsonBody = [NSJSONSerialization dataWithJSONObject:offlineCache options:0 error:&error];
        
        if (error != nil) {
            NSLog(@"error saving offline cache");
            return;
        }
        
        [jsonBody writeToFile:pathForFile options:NSDataWritingAtomic error:&error];
     
        if (error != nil) {
            NSLog(@"error saving offline cache");
            return;
        }
        
    }
    
}


-(void)routeGatewayRequestWith:(NSDictionary *)request path:(NSString *)path method:(NSString *)method handler:(BlockChypCompletionHandler)handler {
    
    self.handler = handler;
    
    BOOL test = (BOOL)[request objectForKey:@"test"];
    
    NSURL *url = [NSURL URLWithString:[self resolveGatewayURLFor:path test:test]];
    
    NSDictionary *headers = [self generateGatewayHeaders];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    urlRequest.HTTPMethod = method;
    [urlRequest addValue:[headers valueForKey:@"Nonce"] forHTTPHeaderField:@"Nonce"];
    [urlRequest addValue:[headers valueForKey:@"Timestamp"] forHTTPHeaderField:@"Timestamp"];
    [urlRequest addValue:[headers valueForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if (method != @"GET") {
        NSError *error;
        NSData *jsonBody = [NSJSONSerialization dataWithJSONObject:request options:0 error:&error];
           
        if (error != nil) {
            self.handler(request, [[NSDictionary alloc] init], error);
            return;
        }
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPBody:jsonBody];
        
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *downloadTask = [session
    dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *urlResponse, NSError *error) {
        
        NSDictionary *response = [[NSDictionary alloc] init];
        
        if (error == nil) {
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            response = [EncodingUtils parseJSON:json];;
        }
    
        self.handler(request, response, error);
    }];
    
    [downloadTask resume];
    
    
}

-(void)routeDashboardRequestWith:(NSDictionary *)request path:(NSString *)path method:(NSString *)method handler:(BlockChypCompletionHandler)handler {
    
    self.handler = handler;
    
    NSURL *url = [NSURL URLWithString:[self resolveDashboardURLFor:path]];
    
    NSDictionary *headers = [self generateGatewayHeaders];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    urlRequest.HTTPMethod = method;
    [urlRequest addValue:[headers valueForKey:@"Nonce"] forHTTPHeaderField:@"Nonce"];
    [urlRequest addValue:[headers valueForKey:@"Timestamp"] forHTTPHeaderField:@"Timestamp"];
    [urlRequest addValue:[headers valueForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
    
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if (method != @"GET") {
        NSError *error;
        NSData *jsonBody = [NSJSONSerialization dataWithJSONObject:request options:0 error:&error];
           
        if (error != nil) {
            self.handler(request, [[NSDictionary alloc] init], error);
            return;
        }
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPBody:jsonBody];
        
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *downloadTask = [session
    dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *urlResponse, NSError *error) {
        
        NSDictionary *response = [[NSDictionary alloc] init];
        
        if (error == nil) {
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            response = [EncodingUtils parseJSON:json];;
        }
    
        self.handler(request, response, error);
    }];
    
    [downloadTask resume];
    
    
}

-(void)routeUploadRequestWith:(NSDictionary *)request path:(NSString *)path content:(NSData *)content handler:(BlockChypCompletionHandler)handler  {
    
    self.handler = handler;
    
    NSURL *url = [NSURL URLWithString:[self resolveDashboardURLFor:path]];
    
    NSDictionary *headers = [self generateGatewayHeaders];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    urlRequest.HTTPMethod = @"POST";
    [urlRequest addValue:[headers valueForKey:@"Nonce"] forHTTPHeaderField:@"Nonce"];
    [urlRequest addValue:[headers valueForKey:@"Timestamp"] forHTTPHeaderField:@"Timestamp"];
    [urlRequest addValue:[headers valueForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString *fileName = [request objectForKey:@"fileName"];
    if (fileName != NULL) {
        [urlRequest setValue:fileName forHTTPHeaderField:@"X-Upload-File-Name"];
    }
    NSString *uploadId = [request objectForKey:@"uploadId"];
    if (uploadId != NULL) {
        [urlRequest setValue:uploadId forHTTPHeaderField:@"X-Upload-ID"];
    }
    NSNumber *fileSize = [request objectForKey:@"fileSize"];
    if (fileSize != NULL) {
        [urlRequest setValue:[fileSize stringValue] forHTTPHeaderField:@"X-File-Size"];
        [urlRequest setValue:[fileSize stringValue] forHTTPHeaderField:@"Content-Length"];
    }
    
    
    [urlRequest setHTTPBody:content];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *downloadTask = [session
    dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *urlResponse, NSError *error) {
        
        NSDictionary *response = [[NSDictionary alloc] init];
        
        if (error == nil) {
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            response = [EncodingUtils parseJSON:json];;
        }
    
        self.handler(request, response, error);
    }];
    
    [downloadTask resume];
    
    
}

-(void)logDictionary:(NSDictionary *)dict {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    if (! jsonData) {
       NSLog(@"%s: error: %@", __func__, error.localizedDescription);
    } else {
       NSLog([[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    }
    
}

@end
