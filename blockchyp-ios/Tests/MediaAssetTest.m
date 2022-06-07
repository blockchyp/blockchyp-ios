// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface MediaAssetTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;
  @property NSDictionary *setupRequest;
  @property NSDictionary *setupResponse;


@end

@implementation MediaAssetTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



  XCTestExpectation *expectation = [self expectationWithDescription:@"MediaAsset Test Setup"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"fileName"] = @"aviato.png";
  request[@"fileSize"] = @18843;
  request[@"uploadId"] = [self getUUID];
  self.setupRequest = request;

    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSString *path = [bundle pathForResource:@"aviato" ofType:@"png"];
  NSData *content = [NSData dataWithContentsOfFile:path];
  [client uploadMediaWithRequest:request content:content handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
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

- (void)testMediaAsset{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  
  XCTestExpectation *expectation = [self expectationWithDescription:@"MediaAsset Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"mediaId"] = [self.setupResponse objectForKey:@"id"];

  [client mediaAssetWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([[response objectForKey:@"success"]boolValue]);
    XCTAssertNotNil([response objectForKey:@"id"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"id"]) length] > 0);
    XCTAssertEqualObjects(@"aviato.png", (NSString *)[response objectForKey:@"originalFile"]);
    XCTAssertNotNil([response objectForKey:@"fileUrl"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"fileUrl"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"thumbnailUrl"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"thumbnailUrl"]) length] > 0);
  
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
