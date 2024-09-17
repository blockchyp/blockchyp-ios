// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface SubmitApplicationTest : BlockChypTest



@end

@implementation SubmitApplicationTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  NSDictionary *profile = [config.profiles objectForKey:@"partner"];
  client.apiKey = (NSString*) [profile objectForKey:@"apiKey"];
  client.bearerToken = (NSString*) [profile objectForKey:@"bearerToken"];
  client.signingKey = (NSString*) [profile objectForKey:@"signingKey"];


}

- (void)tearDown {

}

- (void)testSubmitApplication{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

    NSDictionary *profile = [config.profiles objectForKey:@"partner"];
  client.apiKey = (NSString*) [profile objectForKey:@"apiKey"];
  client.bearerToken = (NSString*) [profile objectForKey:@"bearerToken"];
  client.signingKey = (NSString*) [profile objectForKey:@"signingKey"];
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"SubmitApplication Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"inviteCode"] = @"asdf";
  request[@"dbaName"] = @"BlockChyp";
  request[@"corporateName"] = @"BlockChyp Inc.";
  request[@"webSite"] = @"https://www.blockchyp.com";
  request[@"taxIdNumber"] = @"123456789";
  request[@"entityType"] = @"CORPORATION";
  request[@"stateOfIncorporation"] = @"UT";
  request[@"merchantType"] = @"RETAIL";
  request[@"businessDescription"] = @"Payment processing solutions";
  request[@"yearsInBusiness"] = @"5";
  request[@"businessPhoneNumber"] = @"5555551234";
  NSMutableDictionary *physicaladdress = [[NSMutableDictionary alloc] init];
  physicaladdress[@"address1"] = @"355 S 520 W";
  physicaladdress[@"city"] = @"Lindon";
  physicaladdress[@"stateOrProvince"] = @"UT";
  physicaladdress[@"postalCode"] = @"84042";
  physicaladdress[@"countryCode"] = @"US";
  request[@"physicalAddress"] = physicaladdress;
  NSMutableDictionary *mailingaddress = [[NSMutableDictionary alloc] init];
  mailingaddress[@"address1"] = @"355 S 520 W";
  mailingaddress[@"city"] = @"Lindon";
  mailingaddress[@"stateOrProvince"] = @"UT";
  mailingaddress[@"postalCode"] = @"84042";
  mailingaddress[@"countryCode"] = @"US";
  request[@"mailingAddress"] = mailingaddress;
  request[@"contactFirstName"] = @"John";
  request[@"contactLastName"] = @"Doe";
  request[@"contactPhoneNumber"] = @"5555555678";
  request[@"contactEmail"] = @"john.doe@example.com";
  request[@"contactTitle"] = @"CEO";
  request[@"contactTaxIdNumber"] = @"987654321";
  request[@"contactDOB"] = @"1980-01-01";
  request[@"contactDlNumber"] = @"D1234567";
  request[@"contactDlStateOrProvince"] = @"NY";
  request[@"contactDlExpiration"] = @"2025-12-31";
  NSMutableDictionary *contacthomeaddress = [[NSMutableDictionary alloc] init];
  contacthomeaddress[@"address1"] = @"355 S 520 W";
  contacthomeaddress[@"city"] = @"Lindon";
  contacthomeaddress[@"stateOrProvince"] = @"UT";
  contacthomeaddress[@"postalCode"] = @"84042";
  contacthomeaddress[@"countryCode"] = @"US";
  request[@"contactHomeAddress"] = contacthomeaddress;
  request[@"contactRole"] = @"OWNER";
  NSMutableArray *owners = [[NSMutableArray alloc] init];
NSMutableDictionary *owners1 = [[NSMutableDictionary alloc] init];
owners1[@"firstName"] = @"John";
owners1[@"lastName"] = @"Doe";
owners1[@"jobTitle"] = @"CEO";
owners1[@"taxIdNumber"] = @"876543210";
owners1[@"phoneNumber"] = @"5555559876";
owners1[@"dob"] = @"1981-02-02";
owners1[@"ownership"] = @"50";
owners1[@"email"] = @"john.doe@example.com";
owners1[@"dlNumber"] = @"D7654321";
owners1[@"dlStateOrProvince"] = @"UT";
owners1[@"dlExpiration"] = @"2024-12-31";
NSMutableDictionary *address = [[NSMutableDictionary alloc] init];
  address[@"address1"] = @"355 S 520 W";
  address[@"city"] = @"Lindon";
  address[@"stateOrProvince"] = @"UT";
  address[@"postalCode"] = @"84042";
  address[@"countryCode"] = @"US";
  owners1[@"address"] = address;
[owners addObject:owners1];
  request[@"owners"] = owners;
  NSMutableDictionary *manualaccount = [[NSMutableDictionary alloc] init];
  manualaccount[@"name"] = @"Business Checking";
  manualaccount[@"bank"] = @"Test Bank";
  manualaccount[@"accountHolderName"] = @"BlockChyp Inc.";
  manualaccount[@"routingNumber"] = @"124001545";
  manualaccount[@"accountNumber"] = @"987654321";
  request[@"manualAccount"] = manualaccount;
  request[@"averageTransaction"] = @"100.00";
  request[@"highTransaction"] = @"1000.00";
  request[@"averageMonth"] = @"10000.00";
  request[@"highMonth"] = @"20000.00";
  request[@"refundPolicy"] = @"30_DAYS";
  request[@"refundDays"] = @"30";
  request[@"timeZone"] = @"America/Denver";
  request[@"batchCloseTime"] = @"23:59";
  request[@"multipleLocations"] = @"false";
  request[@"ebtRequested"] = @"false";
  request[@"ecommerce"] = @"true";
  request[@"cardPresentPercentage"] = @"70";
  request[@"phoneOrderPercentage"] = @"10";
  request[@"ecomPercentage"] = @"20";
  request[@"signerName"] = @"John Doe";

  [client submitApplicationWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([[response objectForKey:@"success"]boolValue]);
  
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
