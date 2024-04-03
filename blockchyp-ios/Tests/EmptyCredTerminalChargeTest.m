// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface EmptyCredTerminalChargeTest : BlockChypTest



@end

@implementation EmptyCredTerminalChargeTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



}

- (void)tearDown {

}

- (void)testEmptyCredTerminalCharge{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:@"" bearerToken:@"" signingKey:@""];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  
  XCTestExpectation *expectation = [self expectationWithDescription:@"TerminalCharge Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"terminalName"] = @"Test Terminal";
  request[@"amount"] = @"25.15";
  request[@"test"] = @YES;

  [client chargeWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

      [self logJSON:response];
      XCTAssertNotNil(response);
      // response assertions
      XCTAssertFalse([[response objectForKey:@"success"]boolValue]);
      XCTAssertFalse([[response objectForKey:@"approved"]boolValue]);
      XCTAssertEqualObjects(@"Access Denied", (NSString *)[response objectForKey:@"responseDescription"]);
//      XCTAssertEqualObjects(@"unknown terminal", error.localizedDescription);
    
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
