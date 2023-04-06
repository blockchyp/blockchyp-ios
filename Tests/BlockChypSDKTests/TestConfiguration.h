//
//  TestConfiguration.h
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestConfiguration : NSObject

@property NSString *apiKey;
@property NSString *bearerToken;
@property NSString *signingKey;
@property NSString *gatewayHost;
@property NSString *testGatewayHost;
@property NSString *dashboardHost;
@property NSString *defaultTerminalName;
@property NSString *defaultTerminalAddress;
@property NSDictionary *profiles;


@end

NS_ASSUME_NONNULL_END
