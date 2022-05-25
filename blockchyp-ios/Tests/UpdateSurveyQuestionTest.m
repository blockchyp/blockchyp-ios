//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface UpdateSurveyQuestionTest : BlockChypTest



@end

@implementation UpdateSurveyQuestionTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"UpdateSurveyQuestionTest"];


}

- (void)tearDown {

}

- (void)testUpdateSurveyQuestion{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateSurveyQuestion Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"ordinal"] = @1;
        request[@"questionText"] = @"Would you shop here again?";
        request[@"questionType"] = @"yes_no";

  [client updateSurveyQuestionWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertEqualObjects(@"Would you shop here again?", (NSString *)[response objectForKey:@"questionText"]);
    XCTAssertEqualObjects(@"yes_no", (NSString *)[response objectForKey:@"questionType"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
