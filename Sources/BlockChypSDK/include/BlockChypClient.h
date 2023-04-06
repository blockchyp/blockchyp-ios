//
//  BlockChypClient.h
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int CARD_TYPE_CREDIT = 0;
static const int CARD_TYPE_DEBIT = 1;
static const int CARD_TYPE_EBT = 2;
static const int CARD_TYPE_BLOCKCHAIN_GIFT = 3;
static const int CARD_TYPE_HEALTHCARE = 4;


static const NSString * SIGNATURE_FORMAT_NONE = @"";
static const NSString * SIGNATURE_FORMAT_PNG = @"png";
static const NSString * SIGNATURE_FORMAT_JPG = @"jpg";
static const NSString * SIGNATURE_FORMAT_GIFT = @"gif";

static const NSString * PROMPT_TYPE_AMOUNT = @"amount";
static const NSString * PROMPT_TYPE_EMAIL = @"email";
static const NSString * PROMPT_TYPE_PHONE_NUMBER = @"phone";
static const NSString * PROMPT_TYPE_CUSTOMER_NUMBER = @"customer-number";
static const NSString * PROMPT_TYPE_REWARDS_NUMBER = @"rewards-number";
static const NSString * PROMPT_TYPE_FIRST_NAME = @"first-name";
static const NSString * PROMPT_TYPE_LAST_NAME = @"last-name";

static const NSString * CVM_TYPE_SIGNATURE = @"Signature";
static const NSString * CVM_TYPE_OFFLINE_PIN = @"Offline PIN";
static const NSString * CVM_TYPE_ONLINE_PIN = @"Online PIN";
static const NSString * CVM_TYPE_CDCVM = @"CDCVM";
static const NSString * CVM_TYPE_NO_CVM = @"No CVM";

static const NSString * HEALTHCARE_TYPE_HEALTHCARE = @"healthcare";
static const NSString * HEALTHCARE_TYPE_PRESCRIPTION = @"prescription";
static const NSString * HEALTHCARE_TYPE_VISION = @"vision";
static const NSString * HEALTHCARE_TYPE_CLINIC = @"clinic";
static const NSString * HEALTHCARE_TYPE_DENTAL = @"dental";

NS_ASSUME_NONNULL_BEGIN

typedef void(^BlockChypCompletionHandler)(NSDictionary *request, NSDictionary *response, NSError * _Nullable error);

typedef void(^BlockChypGetCompletionHandler)(NSDictionary *response, NSError * _Nullable error);

@interface BlockChypClient : NSObject

@property NSString *apiKey;
@property NSString *bearerToken;
@property NSString *signingKey;
@property NSString *gatewayHost;
@property NSString *dashboardHost;
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

-(void)routeDashboardRequestWith:(NSDictionary *)request path:(NSString *)path method:(NSString *)method handler:(BlockChypCompletionHandler)handler;

-(void)routeUploadRequestWith:(NSDictionary *)request path:(NSString *)path content:(NSData *)content handler:(BlockChypCompletionHandler)handler ;

@end

NS_ASSUME_NONNULL_END
