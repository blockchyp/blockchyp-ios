//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface CancelPaymentLinkTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;


@end

@implementation CancelPaymentLinkTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"CancelPaymentLinkTest"];


  XCTestExpectation *expectation = [self expectationWithDescription:@"CancelPaymentLink Test Setup"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
      request[@"amount"] = @"199.99";
      request[@"description"] = @"Widget";
      request[@"subject"] = @"Widget invoice";
      [request setObject:[self newTransactionDisplayTransaction] forKey:@"transaction"];
      request[@"autoSend"] = @YES;
      [request setObject:[self newCustomer] forKey:@"customer"];

  [client sendPaymentLinkWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    XCTAssertNil(error);
    self.lastTransactionId = [response objectForKey:@"transactionId"];
    self.lastTransactionRef = [response objectForKey:@"transactionRef"];
    self.lastToken = [response objectForKey:@"lastToken"];
    self.lastCustomerId = [response objectForKey:@"lastCustomerId"];

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:60 handler:nil];


}

- (void)tearDown {

}

- (void)testCancelPaymentLink{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"CancelPaymentLink Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"linkCode"] = self.lastLinkCode;

  [client cancelPaymentLinkWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
