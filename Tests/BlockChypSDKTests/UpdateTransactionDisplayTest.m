// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface UpdateTransactionDisplayTest : BlockChypTest



@end

@implementation UpdateTransactionDisplayTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



}

- (void)tearDown {

}

- (void)testUpdateTransactionDisplay{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  
  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateTransactionDisplay Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  NSMutableDictionary *transaction = [[NSMutableDictionary alloc] init];
  transaction[@"subtotal"] = @"35.00";
  transaction[@"tax"] = @"5.00";
  transaction[@"total"] = @"70.00";
  NSMutableArray *items = [[NSMutableArray alloc] init];
  NSMutableDictionary *items1 = [[NSMutableDictionary alloc] init];
  items1[@"description"] = @"Leki Trekking Poles";
  items1[@"price"] = @"35.00";
  items1[@"quantity"] = @2;
  items1[@"extended"] = @"70.00";
  NSMutableArray *discounts = [[NSMutableArray alloc] init];
  NSMutableDictionary *discounts1 = [[NSMutableDictionary alloc] init];
  discounts1[@"description"] = @"memberDiscount";
  discounts1[@"amount"] = @"10.00";
  [discounts addObject:discounts1];
  items1[@"discounts"] = discounts;
  [items addObject:items1];
  transaction[@"items"] = items;
  request[@"transaction"] = transaction;

  [client updateTransactionDisplayWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([[response objectForKey:@"success"]boolValue]);
  
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
