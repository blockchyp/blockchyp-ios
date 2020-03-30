//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface SearchCustomerTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;


@end

@implementation SearchCustomerTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"SearchCustomerTest"];


  XCTestExpectation *expectation = [self expectationWithDescription:@"SearchCustomer Test Setup"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
      [request setObject:[self newCustomer] forKey:@"customer"];

  [client updateCustomerWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    XCTAssertNil(error);
    self.lastTransactionId = [response objectForKey:@"transactionId"];
    self.lastTransactionRef = [response objectForKey:@"transactionRef"];

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:60 handler:nil];


}

- (void)tearDown {

}

- (void)testSearchCustomer{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"SearchCustomer Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"query"] = @"123123";

  [client customerSearchWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
