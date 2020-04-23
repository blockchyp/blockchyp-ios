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
  request[@"amount"] = @"27.00";
  [client preauthWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"approved"];
    if (success.boolValue) {
      NSLog(@"approved");
    }
    NSLog(@"%@: %@", @"authCode", [response objectForKey:@"authCode"])
    NSLog(@"%@: %@", @"authorizedAmount", [response objectForKey:@"authorizedAmount"])
  }];
  [pool drain];
  return 0;
}

