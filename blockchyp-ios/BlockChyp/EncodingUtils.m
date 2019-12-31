//
//  EncodingUtils.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "EncodingUtils.h"

@implementation EncodingUtils

+(NSDictionary*)parseJSON:(NSString *)JSONString {
    
    NSError *error = nil;
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
    
    if (!error && result) {
        return result;
    } else {
        NSException *e = [NSException exceptionWithName:@"ParseException" reason:[error localizedDescription] userInfo:nil];
        @throw e;
    }
        
    return nil;

}

@end
