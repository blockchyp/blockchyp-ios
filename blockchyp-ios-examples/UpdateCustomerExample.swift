import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["customer"] = newCustomer()
    client.updateCustomer(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("customer" + ": " + (response["customer"] as? String).unsafelyUnwrapped)
    })
  }

  func newCustomer() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"id"] = @"ID of the customer to update";
  val[@"customerRef"] = @"Customer reference string";
  val[@"firstName"] = @"FirstName";
  val[@"lastName"] = @"LastName";
  val[@"companyName"] = @"Company Name";
  val[@"emailAddress"] = @"support@blockchyp.com";
  val[@"smsNumber"] = @"(123) 123-1231";
    return val
  }
