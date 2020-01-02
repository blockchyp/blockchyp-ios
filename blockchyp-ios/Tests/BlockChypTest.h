//
//  BlockChypTest.h
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestConfiguration.h"
#import "../BlockChyp/BlockChyp.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlockChypTest : XCTestCase

-(TestConfiguration*)loadConfiguration;
-(void)logJSON:(NSDictionary *)dict;
-(NSString *)getUUID;
-(void)testDelayWith:(BlockChyp *)client testName:(NSString *)testName;

@end

NS_ASSUME_NONNULL_END
