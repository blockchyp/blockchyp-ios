// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface CancelPaymentLinkTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;
  @property NSDictionary *setupRequest;
  @property NSDictionary *setupResponse;


@end

@implementation CancelPaymentLinkTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



  XCTestExpectation *expectation = [self expectationWithDescription:@"CancelPaymentLink Test Setup"];

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
    customer[@"emailAddress"] = @"notifications@blockchypteam.m8r.co";
    customer[@"smsNumber"] = @"(123) 123-1231";
  request[@"customer"] = customer;
  self.setupRequest = request;

    [client sendPaymentLinkWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
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

- (void)testCancelPaymentLink{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  
  XCTestExpectation *expectation = [self expectationWithDescription:@"CancelPaymentLink Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"linkCode"] = [self.setupResponse objectForKey:@"linkCode"];

  [client cancelPaymentLinkWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

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
