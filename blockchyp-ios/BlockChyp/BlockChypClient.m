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
    
    NSLog(url);
    
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
        NSLog(@"CACHE HIT");
        NSDate *ttl = [routeEntry objectForKey:@"ttl"];
        NSDate *now = [NSDate date];
        if (stale || ([now compare: ttl] == NSOrderedAscending)) {
            return [routeEntry objectForKey:@"route"];
        }
    }
        
    return nil;
    
}




-(void)routeGatewayRequestWith:(NSDictionary *)request path:(NSString *)path method:(NSString *)method handler:(BlockChypCompletionHandler)handler {
    
    HTTPRequestDelegate *delegate = [[HTTPRequestDelegate alloc] initWithClient:self];
       
    [delegate routeGatewayRequestWith:request path:path method:method handler: handler];
    
}

@end
