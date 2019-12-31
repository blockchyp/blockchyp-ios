//
//  HTTPRequestDelegate.h
//  blockchyp-ios
//

#import <Foundation/Foundation.h>
#import "BlockChypClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTTPRequestDelegate : NSObject

@property BlockChypCompletionHandler handler;
@property BlockChypGetCompletionHandler getHandler;

-(id)initWithClient:(BlockChypClient *)client;

-(void)gatewayGetWithPath:(NSString *)path test:(BOOL)test handler:(BlockChypGetCompletionHandler)handler;

-(void)routeTerminalRequestWith:(NSDictionary *)request terminalPath:(NSString *)terminalPath gatewayPath:(NSString *)gatewayPath method:(NSString *)method handler:(BlockChypCompletionHandler)handler;

-(void)routeCachedTerminalRequestWith:(NSDictionary *)request route:(NSDictionary *)route terminalPath:(NSString *)terminalPath gatewayPath:(NSString *)gatewayPath method:(NSString *)method handler:(BlockChypCompletionHandler)handler;


-(void)routeGatewayRequestWith:(NSDictionary *)request path:(NSString *)path method:(NSString *)method handler:(BlockChypCompletionHandler)handler;

@end

NS_ASSUME_NONNULL_END
