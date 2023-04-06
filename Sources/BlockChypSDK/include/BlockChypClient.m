//
//  BlockChypClient.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypClient.h"
#import "EncodingUtils.h"
#import "HTTPRequestDelegate.h"

@implementation BlockChypClient

-(id)init {
    if (self = [super init])  {
        self.https = FALSE;
        self.offlineCacheEnabled = TRUE;
        self.routeCacheTTL = 60;
        self.gatewayTimeout = 20;
        self.terminalTimeout = 120;
        self.gatewayHost = @"https://api.blockchyp.com";
        self.testGatewayHost = @"https://test.blockchyp.com";
        self.dashboardHost = @"https://dashboard.blockchyp.com";
        self.routeCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(id)initWithApiKey:(NSString *)apiKey bearerToken:(NSString *)bearerToken signingKey:(NSString *)signingKey {
    self = [self init];
    self.apiKey = apiKey;
    self.bearerToken = bearerToken;
    self.signingKey = signingKey;
    return self;
}

-(void)gatewayGetFrom:(NSString *)path test:(BOOL)test handler:(BlockChypGetCompletionHandler)handler {
    
    NSString *url = [self resolveGatewayURLFor:path test:test];
    
    NSLog(@"GET: %@", url);
    
    HTTPRequestDelegate *delegate = [[HTTPRequestDelegate alloc] initWithClient:self];
    
    [delegate gatewayGetWithPath:url test:test handler:handler];
    
}

-(NSString *)resolveGatewayURLFor:(NSString *)path test:(bool)test {
    
    NSString *url = [[NSString alloc] init];
    
    if (test) {
        url = [url stringByAppendingString:self.testGatewayHost];
    } else {
        url = [url stringByAppendingString:self.gatewayHost];
    }
    
    return [url stringByAppendingString:path];
    
}

-(NSString *)resolveDashbordURLFor:(NSString *)path {
    
    NSString *url = [[NSString alloc] init];
    url = [url stringByAppendingString:self.dashboardHost];
    return [url stringByAppendingString:path];
    
}

-(void)routeTerminalRequestWith:(NSDictionary *)request terminalPath:(NSString *)terminalPath gatewayPath:(NSString *)gatewayPath method:(NSString *)method handler:(BlockChypCompletionHandler)handler {
    
    HTTPRequestDelegate *delegate = [[HTTPRequestDelegate alloc] initWithClient:self];
    
    
    NSString *terminalName = [request objectForKey:@"terminalName"];
    if ( (terminalName != nil) && ([terminalName length] > 0) ) {
        NSDictionary *route = [self resolveRouteFromCache:terminalName stale:@NO];
        if (route == nil) {
            [delegate routeTerminalRequestWith:request terminalPath:terminalPath gatewayPath:gatewayPath method:method handler:handler];
        } else {
            [delegate routeCachedTerminalRequestWith:request route:route terminalPath:terminalPath gatewayPath:gatewayPath method:method handler:handler];
        }
        
    } else {
        [delegate routeGatewayRequestWith:request path:gatewayPath method:method handler: handler];
    }
    
    

}

-(NSDictionary *)resolveRouteFromCache:(NSString *)terminalName stale:(BOOL)stale {
    
    NSString *routeKey = [NSString stringWithFormat:@"%@%@", self.apiKey, terminalName];
    
    NSDictionary *routeEntry = [self.routeCache objectForKey:routeKey];
    
    if (routeEntry == nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *pathForFile = @".blockchyp_routes";
        if ([fileManager fileExistsAtPath:pathForFile]){
            NSData *jsonData = [NSData dataWithContentsOfFile:pathForFile];
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSDictionary *offlineCache = [EncodingUtils parseJSON:json];
            routeEntry = [offlineCache objectForKey:routeKey];
       }
    }

    if (routeEntry != nil) {
        NSDate *ttl = [routeEntry objectForKey:@"ttl"];
        if (ttl == nil) {
            return nil;
        }
        NSDate *now = [NSDate date];
        if (stale || ([now compare: ttl] == NSOrderedAscending)) {
            return [routeEntry objectForKey:@"route"];
        }
    }
        
    return nil;
    
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




-(void)routeGatewayRequestWith:(NSDictionary *)request path:(NSString *)path method:(NSString *)method handler:(BlockChypCompletionHandler)handler {
    
    HTTPRequestDelegate *delegate = [[HTTPRequestDelegate alloc] initWithClient:self];
       
    [delegate routeGatewayRequestWith:request path:path method:method handler: handler];
    
}

-(void)routeDashboardRequestWith:(NSDictionary *)request path:(NSString *)path method:(NSString *)method handler:(BlockChypCompletionHandler)handler {
    
    HTTPRequestDelegate *delegate = [[HTTPRequestDelegate alloc] initWithClient:self];
       
    [delegate routeDashboardRequestWith:request path:path method:method handler: handler];
    
}

-(void)routeUploadRequestWith:(NSDictionary *)request path:(NSString *)path content:(NSData *)content handler:(BlockChypCompletionHandler)handler {
    
    HTTPRequestDelegate *delegate = [[HTTPRequestDelegate alloc] initWithClient:self];
       
    [delegate routeUploadRequestWith:request path:path content:content handler: handler ];
    
}

@end
