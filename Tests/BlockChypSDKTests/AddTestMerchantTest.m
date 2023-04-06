// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface AddTestMerchantTest : BlockChypTest



@end

@implementation AddTestMerchantTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  NSDictionary *profile = [config.profiles objectForKey:@"partner"];
  client.apiKey = (NSString*) [profile objectForKey:@"apiKey"];
  client.bearerToken = (NSString*) [profile objectForKey:@"bearerToken"];
  client.signingKey = (NSString*) [profile objectForKey:@"signingKey"];


}

- (void)tearDown {

}

- (void)testAddTestMerchant{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

    NSDictionary *profile = [config.profiles objectForKey:@"partner"];
  client.apiKey = (NSString*) [profile objectForKey:@"apiKey"];
  client.bearerToken = (NSString*) [profile objectForKey:@"bearerToken"];
  client.signingKey = (NSString*) [profile objectForKey:@"signingKey"];
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"AddTestMerchant Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"dbaName"] = @"Test Merchant";
  request[@"companyName"] = @"Test Merchant";

  [client addTestMerchantWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([[response objectForKey:@"success"]boolValue]);
    XCTAssertEqualObjects(@"Test Merchant", (NSString *)[response objectForKey:@"dbaName"]);
    XCTAssertEqualObjects(@"Test Merchant", (NSString *)[response objectForKey:@"companyName"]);
    XCTAssertTrue([[response objectForKey:@"visa"]boolValue]);
  
    [expectation fulfill];
  }];

  @try {
      [self waitForExpectationsWithTimeout:60 handler:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"Exception:%@",exception);
  }

}

@end
