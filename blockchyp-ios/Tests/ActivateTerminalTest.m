//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface ActivateTerminalTest : BlockChypTest



@end

@implementation ActivateTerminalTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"ActivateTerminalTest"];


}

- (void)tearDown {

}

- (void)testActivateTerminal{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"ActivateTerminal Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"terminalName"] = @"Bad Terminal Code";
        request[@"activationCode"] = @"XXXXXX";

  [client activateTerminalWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertFalse([response objectForKey:@"success"]);
    XCTAssertEqualObjects(@"Invalid Activation Code", (NSString *)[response objectForKey:@"error"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
