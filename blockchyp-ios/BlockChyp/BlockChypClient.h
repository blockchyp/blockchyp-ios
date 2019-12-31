//
//  BlockChypClient.h
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BlockChypCompletionHandler)(NSDictionary *request, NSDictionary *response, NSError * _Nullable error);

typedef void(^BlockChypGetCompletionHandler)(NSDictionary *response, NSError * _Nullable error);

@interface BlockChypClient : NSObject

@property NSString *apiKey;
@property NSString *bearerToken;
@property NSString *signingKey;
@property NSString *gatewayHost;
@property NSString *testGatewayHost;
@property BOOL https;
@property int routeCacheTTL;
@property int gatewayTimeout;
@property int terminalTimeout;
@property BOOL offlineCacheEnabled;
@property NSMutableDictionary *routeCache;

-(id)initWithApiKey:(NSString *)apiKey bearerToken:(NSString *)bearerToken signingKey:(NSString *)signingKey;

-(void)gatewayGetFrom:(NSString *)path test:(BOOL)test handler:(BlockChypGetCompletionHandler)handler;

-(void)routeTerminalRequestWith:(NSDictionary *)request terminalPath:(NSString *)terminalPath gatewayPath:(NSString *)gatewayPath method:(NSString *)method handler:(BlockChypCompletionHandler)handler;

-(void)routeGatewayRequestWith:(NSDictionary *)request path:(NSString *)path method:(NSString *)method handler:(BlockChypCompletionHandler)handler;


@end

NS_ASSUME_NONNULL_END
