import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["amount"] = "50.00"
      client.giftActivate(withRequest: request, handler: { (request, response, error) in
        let approved = response["approved"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("approved")
      }
      NSLog("amount" + ": " + (response["amount"] as? String).unsafelyUnwrapped)
      NSLog("currentBalance" + ": " + (response["currentBalance"] as? String).unsafelyUnwrapped)
      NSLog("publicKey" + ": " + (response["publicKey"] as? String).unsafelyUnwrapped)
    })
  }

