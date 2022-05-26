//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface AddTestMerchantTest : BlockChypTest



@end

@implementation AddTestMerchantTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"AddTestMerchantTest"];


}

- (void)tearDown {

}

- (void)testAddTestMerchant{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"AddTestMerchant Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"dbaName"] = @"Test Merchant";
        request[@"companyName"] = @"Test Merchant";

  [client addTestMerchantWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertEqualObjects(@"Test Merchant", (NSString *)[response objectForKey:@"dbaName"]);
    XCTAssertEqualObjects(@"Test Merchant", (NSString *)[response objectForKey:@"companyName"]);
    XCTAssertTrue([response objectForKey:@"visa"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
