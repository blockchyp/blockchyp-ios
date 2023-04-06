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
  request["test"] = true
  request["terminalName"] = "Test Terminal"
  var transaction: [String:Any] = [:]
  transaction["subtotal"] = "60.00"
  transaction["tax"] = "5.00"
  transaction["total"] = "65.00"
  var items = [Any]();
  var items1: [String:Any] = [:]
  items1["description"] = "Leki Trekking Poles"
  items1["price"] = "35.00"
  items1["quantity"] = 2
  items1["extended"] = "70.00"
  var discounts = [Any]();
  var discounts1: [String:Any] = [:]
  discounts1["description"] = "memberDiscount"
  discounts1["amount"] = "10.00"
  discounts.append(discounts1)
  items1["discounts"] = discounts
  items.append(items1)
  transaction["items"] = items
  request["transaction"] = transaction
    [client newTransactionDisplayWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
      NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
  }];
  [pool drain];
  return 0;
}
