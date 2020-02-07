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
    request["transaction"] = newTransactionDisplayTransaction()
    client.updateTransactionDisplay(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }

  func newTransactionDisplayTransaction() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"subtotal"] = @"60.00";
  val[@"tax"] = @"5.00";
  val[@"total"] = @"65.00";
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
  val[@"description"] = @"Leki Trekking Poles";
  val[@"price"] = @"35.00";
  val[@"extended"] = @"70.00";
  val[@"discounts"] = [self newTransactionDisplayDiscounts];
    return val;
  }
  func newTransactionDisplayDiscounts()  -> [[String:Any]] {
    var val = [[String:Any]]()
    val.append(newTransactionDisplayDiscount2())
    return val
  }
  func newTransactionDisplayDiscount2() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"description"] = @"memberDiscount";
  val[@"amount"] = @"10.00";
    return val;
  }
