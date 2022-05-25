//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface MediaUploadTest : BlockChypTest



@end

@implementation MediaUploadTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"MediaUploadTest"];


}

- (void)tearDown {

}

- (void)testMediaUpload{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"MediaUpload Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"fileName"] = @"aviato.png";
        request[@"fileSize"] = 18843;
        request[@"uploadId"] = [self getUUID];

  [client uploadMediaWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
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
