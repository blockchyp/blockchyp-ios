//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface TextPromptTest : BlockChypTest



@end

@implementation TextPromptTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"TextPromptTest"];


}

- (void)tearDown {

}

- (void)testTextPrompt{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"TextPrompt Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"test"] = @YES;
        request[@"terminalName"] = @"Test Terminal";
        request[@"promptType"] = PROMPT_TYPE_EMAIL;

  [client textPromptWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertNotNil([response objectForKey:@"response"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"response"]) length] > 0);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
