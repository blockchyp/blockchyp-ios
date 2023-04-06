//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"
#import "../../../Sources/BlockChypSDK/include/BlockChyp.h"

@interface HeartbeatTest : BlockChypTest

@end

@implementation HeartbeatTest

- (void)setUp {

}

- (void)tearDown {

}

- (void)testHeartbeat{
    
    TestConfiguration *config = [self loadConfiguration];
    BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
    client.gatewayHost = config.gatewayHost;
    client.testGatewayHost = config.testGatewayHost;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Heartbeat Test"];
    
    [client heartbeat:TRUE handler:^(NSDictionary *response, NSError *error) {
        [self logJSON:response];
        XCTAssertNotNil(response);
        XCTAssertTrue([response objectForKey:@"success"]);
        XCTAssertNotNil([response objectForKey:@"success"]);
        XCTAssertNotNil([response objectForKey:@"clockchain"]);
        XCTAssertNotNil([response objectForKey:@"latestTick"]);
        XCTAssertNotNil([response objectForKey:@"timestamp"]);
        XCTAssertNotNil([response objectForKey:@"merchantPk"]);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:nil];


}


@end
