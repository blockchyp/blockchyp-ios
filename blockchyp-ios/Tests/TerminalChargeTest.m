// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface TerminalChargeTest : BlockChypTest



@end

@implementation TerminalChargeTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



}

- (void)tearDown {

}

- (void)testTerminalCharge{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
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
    XCTAssertTrue([[response objectForKey:@"success"]boolValue]);
    XCTAssertTrue([[response objectForKey:@"approved"]boolValue]);
    XCTAssertTrue([[response objectForKey:@"test"]boolValue]);
    XCTAssertEqual(6, [((NSString *)[response objectForKey:@"authCode"]) length]);
    XCTAssertNotNil([response objectForKey:@"transactionId"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"transactionId"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"timestamp"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"timestamp"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"tickBlock"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"tickBlock"]) length] > 0);
    XCTAssertEqualObjects(@"approved", (NSString *)[response objectForKey:@"responseDescription"]);
    XCTAssertNotNil([response objectForKey:@"paymentType"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"paymentType"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"maskedPan"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"maskedPan"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"entryMethod"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"entryMethod"]) length] > 0);
    XCTAssertEqualObjects(@"25.15", (NSString *)[response objectForKey:@"authorizedAmount"]);
  
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
