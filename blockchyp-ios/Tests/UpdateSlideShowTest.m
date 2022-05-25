//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface UpdateSlideShowTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;


@end

@implementation UpdateSlideShowTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"UpdateSlideShowTest"];


  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateSlideShow Test Setup"];

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

- (void)testUpdateSlideShow{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateSlideShow Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"name"] = @"Test Slide Show";
        request[@"delay"] = @5;
    
  [client updateSlideShowWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertEqualObjects(@"Test Slide Show", (NSString *)[response objectForKey:@"name"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}

- (NSArray *) newSlides {
  NSMutableArray *val = [[NSMutableArray alloc] init];
  [val addObject: [self newSlide1]];
  return val;
}
- (NSDictionary *) newSlide1 {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  return val;
}


@end
