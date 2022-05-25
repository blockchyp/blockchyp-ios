//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface MediaAssetTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;


@end

@implementation MediaAssetTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"MediaAssetTest"];


  XCTestExpectation *expectation = [self expectationWithDescription:@"MediaAsset Test Setup"];

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

- (void)testMediaAsset{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"MediaAsset Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
    
  [client mediaAssetWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertNotNil([response objectForKey:@"id"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"id"]) length] > 0);
    XCTAssertEqualObjects(@"aviato.png", (NSString *)[response objectForKey:@"originalFile"]);
    XCTAssertNotNil([response objectForKey:@"fileUrl"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"fileUrl"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"thumbnailUrl"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"thumbnailUrl"]) length] > 0);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
