// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface PANEnrollTest : BlockChypTest



@end

@implementation PANEnrollTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



}

- (void)tearDown {

}

- (void)testPANEnroll{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  
  XCTestExpectation *expectation = [self expectationWithDescription:@"PANEnroll Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"pan"] = @"4111111111111111";
  request[@"test"] = @YES;
  NSMutableDictionary *customer = [[NSMutableDictionary alloc] init];
  customer[@"customerRef"] = @"TESTCUSTOMER";
  customer[@"firstName"] = @"Test";
  customer[@"lastName"] = @"Customer";
  request[@"customer"] = customer;

  [client enrollWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

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
    XCTAssertEqualObjects(@"KEYED", (NSString *)[response objectForKey:@"entryMethod"]);
    XCTAssertNotNil([response objectForKey:@"token"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"token"]) length] > 0);
  
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
