//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface SimpleReversalTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;


@end

@implementation SimpleReversalTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"SimpleReversalTest"];


  XCTestExpectation *expectation = [self expectationWithDescription:@"SimpleReversal Test Setup"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
      request[@"pan"] = @"4111111111111111";
      request[@"expMonth"] = @"12";
      request[@"expYear"] = @"2025";
      request[@"amount"] = @"25.55";
      request[@"test"] = @YES;
      request[@"transactionRef"] = [self getUUID];

  [client chargeWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    XCTAssertNil(error);
    self.lastTransactionId = [response objectForKey:@"transactionId"];
    self.lastTransactionRef = [response objectForKey:@"transactionRef"];

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:60 handler:nil];


}

- (void)tearDown {

}

- (void)testSimpleReversal{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"SimpleReversal Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"transactionRef"] = self.lastTransactionRef;
        request[@"test"] = @YES;

  [client reverseWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertTrue([response objectForKey:@"approved"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
