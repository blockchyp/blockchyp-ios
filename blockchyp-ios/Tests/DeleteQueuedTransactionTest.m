//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface DeleteQueuedTransactionTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;


@end

@implementation DeleteQueuedTransactionTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"DeleteQueuedTransactionTest"];


  XCTestExpectation *expectation = [self expectationWithDescription:@"DeleteQueuedTransaction Test Setup"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
      request[@"terminalName"] = @"Test Terminal";
      request[@"transactionRef"] = [self getUUID];
      request[@"description"] = @"1060 West Addison";
      request[@"amount"] = @"25.15";
      request[@"test"] = @YES;
      request[@"queue"] = @YES;

  [client chargeWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

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

- (void)testDeleteQueuedTransaction{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"DeleteQueuedTransaction Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"terminalName"] = @"Test Terminal";
        request[@"transactionRef"] = @"*";

  [client deleteQueuedTransactionWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
