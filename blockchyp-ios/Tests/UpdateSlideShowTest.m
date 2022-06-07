// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface UpdateSlideShowTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;
  @property NSDictionary *setupRequest;
  @property NSDictionary *setupResponse;


@end

@implementation UpdateSlideShowTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateSlideShow Test Setup"];

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

- (void)testUpdateSlideShow{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  
  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateSlideShow Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"name"] = @"Test Slide Show";
  request[@"delay"] = @5;
  NSMutableArray *slides = [[NSMutableArray alloc] init];
NSMutableDictionary *slides1 = [[NSMutableDictionary alloc] init];
slides1[@"mediaId"] = [self.setupResponse objectForKey:@"id"];
[slides addObject:slides1];
  request[@"slides"] = slides;

  [client updateSlideShowWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([[response objectForKey:@"success"]boolValue]);
    XCTAssertEqualObjects(@"Test Slide Show", (NSString *)[response objectForKey:@"name"]);
  
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
