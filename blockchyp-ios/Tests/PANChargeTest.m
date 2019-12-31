//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"
#import "../BlockChyp/BlockChyp.h"

@interface PANChargeTest : BlockChypTest



@end

@implementation PANChargeTest

- (void)setUp {


}

- (void)tearDown {

}

- (void)testPANCharge{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"PANCharge Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"pan"] = @"4111111111111111";
        request[@"amount"] = @"25.55";
        request[@"test"] = @YES;
    
  [client chargeWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"approved"]);
    XCTAssertTrue([response objectForKey:@"test"]);
    XCTAssertEqual(6, [((NSString *)[response objectForKey:@"authCode"]) length]);
    XCTAssertNotNil([response objectForKey:@"transactionId"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"transactionId"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"timestamp"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"timestamp"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"tickBlock"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"tickBlock"]) length] > 0);
    XCTAssertEqualObjects(@"Approved", (NSString *)[response objectForKey:@"responseDescription"]);
    XCTAssertNotNil([response objectForKey:@"paymentType"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"paymentType"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"maskedPan"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"maskedPan"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"entryMethod"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"entryMethod"]) length] > 0);
    XCTAssertEqualObjects(@"25.55", (NSString *)[response objectForKey:@"authorizedAmount"]);
    XCTAssertEqualObjects(@"KEYED", (NSString *)[response objectForKey:@"entryMethod"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
