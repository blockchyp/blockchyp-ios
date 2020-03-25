import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["amount"] = "199.99"
    request["description"] = "Widget"
    request["subject"] = "Widget invoice"
    request["transaction"] = newTransactionDisplayTransaction()
    request["autoSend"] = true
    request["customer"] = newCustomer()
    client.sendPaymentLink(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("responseDescription" + ": " + (response["responseDescription"] as? String).unsafelyUnwrapped)
      NSLog("authorizedAmount" + ": " + (response["authorizedAmount"] as? String).unsafelyUnwrapped)
    })
  }

  func newTransactionDisplayTransaction() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"subtotal"] = @"195.00";
  val[@"tax"] = @"4.99";
  val[@"total"] = @"199.99";
  val[@"items"] = [self newTransactionDisplayItems];
    return val
  }
  func newTransactionDisplayItems()  -> [[String:Any]] {
    var val = [[String:Any]]()
    val.append(newTransactionDisplayItem2())
    return val
  }
  func newTransactionDisplayItem2() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"description"] = @"Widget";
  val[@"price"] = @"195.00";
    return val;
  }
  func newCustomer() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"customerRef"] = @"Customer reference string";
  val[@"firstName"] = @"FirstName";
  val[@"lastName"] = @"LastName";
  val[@"companyName"] = @"Company Name";
  val[@"emailAddress"] = @"support@blockchyp.com";
  val[@"smsNumber"] = @"(123) 123-1231";
    return val
  }
