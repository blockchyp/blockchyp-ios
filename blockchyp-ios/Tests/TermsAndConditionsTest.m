//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface TermsAndConditionsTest : BlockChypTest



@end

@implementation TermsAndConditionsTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"TermsAndConditionsTest"];


}

- (void)tearDown {

}

- (void)testTermsAndConditions{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"TermsAndConditions Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"test"] = @YES;
        request[@"terminalName"] = @"Test Terminal";
        request[@"tcName"] = @"HIPPA Disclosure";
        request[@"tcContent"] = @"Full contract text";
        request[@"sigFormat"] = SIGNATURE_FORMAT_PNG;
        request[@"sigWidth"] = @200;
        request[@"sigRequired"] = @YES;

  [client termsAndConditionsWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
