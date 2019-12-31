//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"
#import "../BlockChyp/BlockChyp.h"

@interface SimplePingTest : BlockChypTest



@end

@implementation SimplePingTest

- (void)setUp {


}

- (void)tearDown {

}

- (void)testSimplePing{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"SimplePing Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"test"] = @YES;
        request[@"terminalName"] = @"Test Terminal";

  [client pingWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
