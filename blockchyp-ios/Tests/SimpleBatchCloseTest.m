//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"
#import "../BlockChyp/BlockChyp.h"

@interface SimpleBatchCloseTest : BlockChypTest



@end

@implementation SimpleBatchCloseTest

- (void)setUp {


}

- (void)tearDown {

}

- (void)testSimpleBatchClose{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"SimpleBatchClose Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"test"] = @YES;

  [client closeBatchWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertNotNil([response objectForKey:@"capturedTotal"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"capturedTotal"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"openPreauths"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"openPreauths"]) length] > 0);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
