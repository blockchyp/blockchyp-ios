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
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  [request setObject:[self newTransactionDisplayTransaction] forKey:@"transaction"];
  [client newTransactionDisplayWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
  }];
  [pool drain];
  return 0;
}

- (NSDictionary *) newTransactionDisplayTransaction {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"subtotal"] = @"60.00";
  val[@"tax"] = @"5.00";
  val[@"total"] = @"65.00";
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
  val[@"description"] = @"Leki Trekking Poles";
  val[@"price"] = @"35.00";
  val[@"extended"] = @"70.00";
  val[@"discounts"] = [self newTransactionDisplayDiscounts];
  return val;
}
- (NSArray *) newTransactionDisplayDiscounts {
  NSMutableArray *val = [[NSMutableArray alloc] init];
  [val addObject: [self newTransactionDisplayDiscount2]];
  return val;
}
- (NSDictionary *) newTransactionDisplayDiscount2 {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"description"] = @"memberDiscount";
  val[@"amount"] = @"10.00";
  return val;
}
