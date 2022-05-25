//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface UpdateBrandingAssetTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;


@end

@implementation UpdateBrandingAssetTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"UpdateBrandingAssetTest"];


  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateBrandingAsset Test Setup"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
      request[@"fileName"] = @"aviato.png";
      request[@"fileSize"] = 18843;
      request[@"uploadId"] = [self getUUID];

  [client uploadMediaWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

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

- (void)testUpdateBrandingAsset{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateBrandingAsset Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
            request[@"padded"] = @YES;
        request[@"ordinal"] = @10;
        request[@"startDate"] = @"01/06/2021";
        request[@"startTime"] = @"14:00";
        request[@"endDate"] = @"11/05/2024";
        request[@"endTime"] = @"16:00";
        request[@"notes"] = @"Test Branding Asset";
        request[@"preview"] = @NO;
        request[@"enabled"] = @YES;

  [client updateBrandingAssetWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
