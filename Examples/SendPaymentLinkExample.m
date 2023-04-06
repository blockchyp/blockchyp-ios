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
  request["transactionRef"] = "<TX REF>"
  request["amount"] = "199.99"
  request["description"] = "Widget"
  request["subject"] = "Widget invoice"
  var transaction: [String:Any] = [:]
  transaction["subtotal"] = "195.00"
  transaction["tax"] = "4.99"
  transaction["total"] = "199.99"
  var items = [Any]();
  var items1: [String:Any] = [:]
  items1["description"] = "Widget"
  items1["price"] = "195.00"
  items1["quantity"] = 1
  items.append(items1)
  transaction["items"] = items
  request["transaction"] = transaction
  request["autoSend"] = true
  var customer: [String:Any] = [:]
  customer["customerRef"] = "Customer reference string"
  customer["firstName"] = "FirstName"
  customer["lastName"] = "LastName"
  customer["companyName"] = "Company Name"
  customer["emailAddress"] = "notifications@blockchypteam.m8r.co"
  customer["smsNumber"] = "(123) 123-1231"
  request["customer"] = customer
    [client sendPaymentLinkWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
      NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"url", [response objectForKey:@"url"])
  }];
  [pool drain];
  return 0;
}
