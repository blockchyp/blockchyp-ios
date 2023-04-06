// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface UpdateSurveyQuestionTest : BlockChypTest



@end

@implementation UpdateSurveyQuestionTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



}

- (void)tearDown {

}

- (void)testUpdateSurveyQuestion{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  
  XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateSurveyQuestion Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"ordinal"] = @1;
  request[@"questionText"] = @"Would you shop here again?";
  request[@"questionType"] = @"yes_no";

  [client updateSurveyQuestionWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([[response objectForKey:@"success"]boolValue]);
    XCTAssertEqualObjects(@"Would you shop here again?", (NSString *)[response objectForKey:@"questionText"]);
    XCTAssertEqualObjects(@"yes_no", (NSString *)[response objectForKey:@"questionType"]);
  
    [expectation fulfill];
  }];

  @try {
      [self waitForExpectationsWithTimeout:60 handler:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"Exception:%@",exception);
  }

}

@end
