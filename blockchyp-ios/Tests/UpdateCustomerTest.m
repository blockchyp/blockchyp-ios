//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface UpdateCustomerTest : BlockChypTest



@end

@implementation UpdateCustomerTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"UpdateCustomerTest"];


}

- (void)tearDown {

}

- (void)testUpdateCustomer{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateCustomer Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        [request setObject:[self newCustomer] forKey:@"customer"];

  [client updateCustomerWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}

- (NSDictionary *) newCustomer {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"firstName"] = @"Test";
  val[@"lastName"] = @"Customer";
  val[@"companyName"] = @"Test Company";
  val[@"emailAddress"] = @"support@blockchyp.com";
  val[@"smsNumber"] = @"(123) 123-1234";
  return val;
}


@end
