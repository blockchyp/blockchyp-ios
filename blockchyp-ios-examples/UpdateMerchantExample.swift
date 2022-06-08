import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["merchantId"] = "<MERCHANT ID>"
    request["test"] = true
    request["dbaName"] = "Test Merchant"
    request["companyName"] = "Test Merchant"
    var billingaddress: [String:Any] = [:]
    billingaddress["address1"] = "1060 West Addison"
    billingaddress["city"] = "Chicago"
    billingaddress["stateOrProvince"] = "IL"
    billingaddress["postalCode"] = "60613"
    request["billingAddress"] = billingaddress
      client.updateMerchant(withRequest: request, handler: { (request, response, error) in
        let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }

