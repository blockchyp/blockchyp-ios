#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"amount"] = @"199.99";
  request[@"description"] = @"Widget";
  request[@"subject"] = @"Widget invoice";
  [request setObject:[self newTransactionDisplayTransaction] forKey:@"transaction"];
  request[@"autoSend"] = @YES;
  [request setObject:[self newCustomer] forKey:@"customer"];
  [client sendPaymentLinkWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"responseDescription", [response objectForKey:@"responseDescription"])
    NSLog(@"%@: %@", @"authorizedAmount", [response objectForKey:@"authorizedAmount"])
  }];
  [pool drain];
  return 0;
}

- (NSDictionary *) newTransactionDisplayTransaction {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"subtotal"] = @"195.00";
  val[@"tax"] = @"4.99";
  val[@"total"] = @"199.99";
  val[@"items"] = [self newTransactionDisplayItems];
  return val;
}
- (NSArray *) newTransactionDisplayItems {
  NSMutableArray *val = [[NSMutableArray alloc] init];
  [val addObject: [self newTransactionDisplayItem2]];
  return val;
}
- (NSDictionary *) newTransactionDisplayItem2 {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"description"] = @"Widget";
  val[@"price"] = @"195.00";
  return val;
}
- (NSDictionary *) newCustomer {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"customerRef"] = @"Customer reference string";
  val[@"firstName"] = @"FirstName";
  val[@"lastName"] = @"LastName";
  val[@"companyName"] = @"Company Name";
  val[@"emailAddress"] = @"support@blockchyp.com";
  val[@"smsNumber"] = @"(123) 123-1231";
  return val;
}
