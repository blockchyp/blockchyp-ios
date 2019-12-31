//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"
#import "../BlockChyp/BlockChyp.h"

@interface TerminalEBTBalanceTest : BlockChypTest



@end

@implementation TerminalEBTBalanceTest

- (void)setUp {


}

- (void)tearDown {

}

- (void)testTerminalEBTBalance{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"TerminalEBTBalance Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"test"] = @YES;
        request[@"terminalName"] = @"Test Terminal";
        request[@"cardType"] = @(CardType)EBT;

  [client balanceWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertNotNil([response objectForKey:@"remainingBalance"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"remainingBalance"]) length] > 0);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
