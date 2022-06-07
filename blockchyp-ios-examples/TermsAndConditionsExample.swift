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
    request["tcAlias"] = "hippa"
    request["tcName"] = "HIPPA Disclosure"
    request["tcContent"] = "Full contract text"
    request["sigFormat"] = SIGNATURE_FORMAT_PNG
    request["sigWidth"] = 200
    request["sigRequired"] = true
      client.termsAndConditions(withRequest: request, handler: { (request, response, error) in
        let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("sig" + ": " + (response["sig"] as? String).unsafelyUnwrapped)
      NSLog("sigFile" + ": " + (response["sigFile"] as? String).unsafelyUnwrapped)
    })
  }

