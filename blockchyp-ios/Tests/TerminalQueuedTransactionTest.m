//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface TerminalQueuedTransactionTest : BlockChypTest



@end

@implementation TerminalQueuedTransactionTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"TerminalQueuedTransactionTest"];


}

- (void)tearDown {

}

- (void)testTerminalQueuedTransaction{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"TerminalQueuedTransaction Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"terminalName"] = @"Test Terminal";
        request[@"transactionRef"] = [self getUUID];
        request[@"description"] = @"1060 West Addison";
        request[@"amount"] = @"25.15";
        request[@"test"] = @YES;
        request[@"queue"] = @YES;

  [client chargeWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertFalse([response objectForKey:@"approved"]);
    XCTAssertEqualObjects(@"Queued", (NSString *)[response objectForKey:@"responseDescription"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
