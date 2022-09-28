import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
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
      client.sendPaymentLink(withRequest: request, handler: { (request, response, error) in
        let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("url" + ": " + (response["url"] as? String).unsafelyUnwrapped)
    })
  }

