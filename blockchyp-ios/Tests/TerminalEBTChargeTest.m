//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface TerminalEBTChargeTest : BlockChypTest



@end

@implementation TerminalEBTChargeTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"TerminalEBTChargeTest"];


}

- (void)tearDown {

}

- (void)testTerminalEBTCharge{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"TerminalEBTCharge Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"terminalName"] = @"Test Terminal";
        request[@"amount"] = @"25.00";
        request[@"test"] = @YES;
        request[@"cardType"] = [NSNumber numberWithInt:CARD_TYPE_EBT];

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
    XCTAssertEqualObjects(@"Approved", (NSString *)[response objectForKey:@"responseDescription"]);
    XCTAssertNotNil([response objectForKey:@"paymentType"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"paymentType"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"maskedPan"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"maskedPan"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"entryMethod"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"entryMethod"]) length] > 0);
    XCTAssertEqualObjects(@"25.00", (NSString *)[response objectForKey:@"authorizedAmount"]);
    XCTAssertEqualObjects(@"75.00", (NSString *)[response objectForKey:@"remainingBalance"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
