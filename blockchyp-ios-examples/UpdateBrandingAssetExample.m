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
  request["mediaId"] = "<MEDIA ID>"
  request["padded"] = true
  request["ordinal"] = 10
  request["startDate"] = "01/06/2021"
  request["startTime"] = "14:00"
  request["endDate"] = "11/05/2024"
  request["endTime"] = "16:00"
  request["notes"] = "Test Branding Asset"
  request["preview"] = false
  request["enabled"] = true
    [client updateBrandingAssetWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
      NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
  }];
  [pool drain];
  return 0;
}
