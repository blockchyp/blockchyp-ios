// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface AddGatewayMerchantTest : BlockChypTest



@end

@implementation AddGatewayMerchantTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  NSDictionary *profile = [config.profiles objectForKey:@"partner"];
  client.apiKey = (NSString*) [profile objectForKey:@"apiKey"];
  client.bearerToken = (NSString*) [profile objectForKey:@"bearerToken"];
  client.signingKey = (NSString*) [profile objectForKey:@"signingKey"];


}

- (void)tearDown {

}

- (void)testAddGatewayMerchant{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

    NSDictionary *profile = [config.profiles objectForKey:@"partner"];
  client.apiKey = (NSString*) [profile objectForKey:@"apiKey"];
  client.bearerToken = (NSString*) [profile objectForKey:@"bearerToken"];
  client.signingKey = (NSString*) [profile objectForKey:@"signingKey"];
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"AddGatewayMerchant Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  NSMutableDictionary *profile = [[NSMutableDictionary alloc] init];
  profile[@"dbaName"] = @"DBA Name";
  profile[@"companyName"] = @"Corporate Entity Name";
  request[@"profile"] = profile;

  [client addGatewayMerchantWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

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
