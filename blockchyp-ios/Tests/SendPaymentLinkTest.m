//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface SendPaymentLinkTest : BlockChypTest



@end

@implementation SendPaymentLinkTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"SendPaymentLinkTest"];


}

- (void)tearDown {

}

- (void)testSendPaymentLink{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"SendPaymentLink Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"amount"] = @"199.99";
        request[@"description"] = @"Widget";
        request[@"subject"] = @"Widget invoice";
        [request setObject:[self newTransactionDisplayTransaction] forKey:@"transaction"];
        request[@"autoSend"] = @YES;
        [request setObject:[self newCustomer] forKey:@"customer"];

  [client sendPaymentLinkWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertNotNil([response objectForKey:@"url"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"url"]) length] > 0);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}

- (NSDictionary *) newTransactionDisplayTransaction {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"subtotal"] = @"195.00";
  val[@"tax"] = @"4.99";
  val[@"total"] = @"199.99";
  val[@"items"] = [self newTransactionDisplayItems];
  return val;
}
- (NSArray *) newTransactionDisplayItems {
  NSMutableArray *val = [[NSMutableArray alloc] init];
  [val addObject: [self newTransactionDisplayItem2]];
  return val;
}
- (NSDictionary *) newTransactionDisplayItem2 {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"description"] = @"Widget";
  val[@"price"] = @"195.00";
  return val;
}
- (NSDictionary *) newCustomer {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"customerRef"] = @"Customer reference string";
  val[@"firstName"] = @"FirstName";
  val[@"lastName"] = @"LastName";
  val[@"companyName"] = @"Company Name";
  val[@"emailAddress"] = @"support@blockchyp.com";
  val[@"smsNumber"] = @"(123) 123-1231";
  return val;
}


@end
