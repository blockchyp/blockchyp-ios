import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
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
      client.updateBrandingAsset(withRequest: request, handler: { (request, response, error) in
        let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }

