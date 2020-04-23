//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface TerminalKeyedChargeTest : BlockChypTest



@end

@implementation TerminalKeyedChargeTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"TerminalKeyedChargeTest"];


}

- (void)tearDown {

}

- (void)testTerminalKeyedCharge{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"TerminalKeyedCharge Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"terminalName"] = @"Test Terminal";
        request[@"amount"] = @"11.11";
        request[@"manualEntry"] = @YES;
        request[@"test"] = @YES;

  [client chargeWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertTrue([response objectForKey:@"approved"]);
    XCTAssertTrue([response objectForKey:@"test"]);
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
    XCTAssertEqualObjects(@"11.11", (NSString *)[response objectForKey:@"authorizedAmount"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
