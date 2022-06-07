// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface TCEntryTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;
  @property NSDictionary *setupRequest;
  @property NSDictionary *setupResponse;


@end

@implementation TCEntryTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



  XCTestExpectation *expectation = [self expectationWithDescription:@"TCEntry Test Setup"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  self.setupRequest = request;

    [client tcLogWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
      XCTAssertNil(error);
    self.setupResponse = response;
    self.lastTransactionId = [response objectForKey:@"transactionId"];
    self.lastTransactionRef = [response objectForKey:@"transactionRef"];
    self.lastToken = [response objectForKey:@"token"];
    NSDictionary *customer = (NSDictionary*)[response objectForKey:@"customer"];
    if ( (customer != NULL) && (customer != [NSNull null])) {
        self.lastCustomerId = [customer objectForKey:@"id"];
    }
    [expectation fulfill];
  }];

  @try {
    [self waitForExpectationsWithTimeout:60 handler:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"Exception:%@",exception);
  }

}

- (void)tearDown {

}

- (void)testTCEntry{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  
  XCTestExpectation *expectation = [self expectationWithDescription:@"TCEntry Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"logEntryId"] = [(NSDictionary *)[(NSArray *)[self.setupResponse objectForKey:@"results"] firstObject] objectForKey:@"id"];

  [client tcEntryWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([[response objectForKey:@"success"]boolValue]);
    XCTAssertNotNil([response objectForKey:@"id"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"id"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"terminalId"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"terminalId"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"terminalName"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"terminalName"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"timestamp"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"timestamp"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"name"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"name"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"content"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"content"]) length] > 0);
    XCTAssertTrue([[response objectForKey:@"hasSignature"]boolValue]);
    XCTAssertNotNil([response objectForKey:@"signature"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"signature"]) length] > 0);
  
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
