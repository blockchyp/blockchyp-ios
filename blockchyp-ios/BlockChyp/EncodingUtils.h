//
//  EncodingUtils.h
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EncodingUtils : NSObject
{
}
+(NSDictionary*)parseJSON:(NSString *)JSONString;

@end

NS_ASSUME_NONNULL_END
