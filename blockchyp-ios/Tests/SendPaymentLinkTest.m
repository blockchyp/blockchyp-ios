// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface SendPaymentLinkTest : BlockChypTest



@end

@implementation SendPaymentLinkTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



}

- (void)tearDown {

}

- (void)testSendPaymentLink{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  
  XCTestExpectation *expectation = [self expectationWithDescription:@"SendPaymentLink Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"amount"] = @"199.99";
  request[@"description"] = @"Widget";
  request[@"subject"] = @"Widget invoice";
  NSMutableDictionary *transaction = [[NSMutableDictionary alloc] init];
  transaction[@"subtotal"] = @"195.00";
  transaction[@"tax"] = @"4.99";
  transaction[@"total"] = @"199.99";
  NSMutableArray *items = [[NSMutableArray alloc] init];
  NSMutableDictionary *items1 = [[NSMutableDictionary alloc] init];
  items1[@"description"] = @"Widget";
  items1[@"price"] = @"195.00";
  items1[@"quantity"] = @1;
  [items addObject:items1];
  transaction[@"items"] = items;
  request[@"transaction"] = transaction;
  request[@"autoSend"] = @YES;
  NSMutableDictionary *customer = [[NSMutableDictionary alloc] init];
  customer[@"customerRef"] = @"Customer reference string";
  customer[@"firstName"] = @"FirstName";
  customer[@"lastName"] = @"LastName";
  customer[@"companyName"] = @"Company Name";
  customer[@"emailAddress"] = @"support@blockchyp.com";
  customer[@"smsNumber"] = @"(123) 123-1231";
  request[@"customer"] = customer;

  [client sendPaymentLinkWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([[response objectForKey:@"success"]boolValue]);
    XCTAssertNotNil([response objectForKey:@"url"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"url"]) length] > 0);
  
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
