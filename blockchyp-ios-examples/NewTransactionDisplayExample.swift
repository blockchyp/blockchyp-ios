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
    var transaction: [String:Any] = [:]
    transaction["subtotal"] = "60.00"
    transaction["tax"] = "5.00"
    transaction["total"] = "65.00"
    var items = [Any]();
    var items1: [String:Any] = [:]
    items1["description"] = "Leki Trekking Poles"
    items1["price"] = "35.00"
    items1["quantity"] = 2
    items1["extended"] = "70.00"
    var discounts = [Any]();
    var discounts1: [String:Any] = [:]
    discounts1["description"] = "memberDiscount"
    discounts1["amount"] = "10.00"
    discounts.append(discounts1)
    items1["discounts"] = discounts
    items.append(items1)
    transaction["items"] = items
    request["transaction"] = transaction
      client.newTransactionDisplay(withRequest: request, handler: { (request, response, error) in
        let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }

