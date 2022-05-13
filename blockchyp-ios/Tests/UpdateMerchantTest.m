//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface UpdateMerchantTest : BlockChypTest



@end

@implementation UpdateMerchantTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"UpdateMerchantTest"];


}

- (void)tearDown {

}

- (void)testUpdateMerchant{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateMerchant Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"test"] = @YES;
        request[@"dbaName"] = @"Test Merchant";
        request[@"companyName"] = @"Test Merchant";
        [request setObject:[self newAddress] forKey:@"billingAddress"];

  [client updateMerchantWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}

- (NSDictionary *) newAddress {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"address1"] = @"1060 West Addison";
  val[@"city"] = @"Chicago";
  val[@"stateOrProvince"] = @"IL";
  val[@"postalCode"] = @"60613";
  return val;
}


@end
