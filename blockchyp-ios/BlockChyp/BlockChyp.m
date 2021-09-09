//
//  BlockChyp.m
//
//  Created by Jeff Payne on 12/15/19.
//

#import "BlockChyp.h"

@implementation BlockChyp

-(void)heartbeat:(BOOL)test handler:(BlockChypGetCompletionHandler)handler; {

    [self gatewayGetFrom:@"/api/heartbeat" test:test handler:handler];

}


// Tests connectivity with a payment terminal.
-(void)pingWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/test" gatewayPath:@"/api/terminal-test" method:@"POST" handler:handler];

}

// Executes a standard direct preauth and capture.
-(void)chargeWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/charge" gatewayPath:@"/api/charge" method:@"POST" handler:handler];

}

// Executes a preauthorization intended to be captured later.
-(void)preauthWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/preauth" gatewayPath:@"/api/preauth" method:@"POST" handler:handler];

}

// Executes a refund.
-(void)refundWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/refund" gatewayPath:@"/api/refund" method:@"POST" handler:handler];

}

// Adds a new payment method to the token vault.
-(void)enrollWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/enroll" gatewayPath:@"/api/enroll" method:@"POST" handler:handler];

}

// Activates or recharges a gift card.
-(void)giftActivateWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/gift-activate" gatewayPath:@"/api/gift-activate" method:@"POST" handler:handler];

}

// Checks the remaining balance on a payment method.
-(void)balanceWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/balance" gatewayPath:@"/api/balance" method:@"POST" handler:handler];

}

// Clears the line item display and any in progress transaction.
-(void)clearWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/clear" gatewayPath:@"/api/terminal-clear" method:@"POST" handler:handler];

}

// Returns the current status of a terminal.
-(void)terminalStatusWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/terminal-status" gatewayPath:@"/api/terminal-status" method:@"POST" handler:handler];

}

// Prompts the user to accept terms and conditions.
-(void)termsAndConditionsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/tc" gatewayPath:@"/api/terminal-tc" method:@"POST" handler:handler];

}

// Captures and returns a signature.
-(void)captureSignatureWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/capture-signature" gatewayPath:@"/api/capture-signature" method:@"POST" handler:handler];

}

// Displays a new transaction on the terminal.
-(void)newTransactionDisplayWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/txdisplay" gatewayPath:@"/api/terminal-txdisplay" method:@"POST" handler:handler];

}

// Appends items to an existing transaction display. Subtotal, Tax, and Total
// are overwritten by the request. Items with the same description are
// combined into groups.
-(void)updateTransactionDisplayWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/txdisplay" gatewayPath:@"/api/terminal-txdisplay" method:@"PUT" handler:handler];

}

// Displays a short message on the terminal.
-(void)messageWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/message" gatewayPath:@"/api/message" method:@"POST" handler:handler];

}

// Asks the consumer a yes/no question.
-(void)booleanPromptWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/boolean-prompt" gatewayPath:@"/api/boolean-prompt" method:@"POST" handler:handler];

}

// Asks the consumer a text based question.
-(void)textPromptWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/text-prompt" gatewayPath:@"/api/text-prompt" method:@"POST" handler:handler];

}

// Returns a list of queued transactions on a terminal.
-(void)listQueuedTransactionsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/queue/list" gatewayPath:@"/api/queue/list" method:@"GET" handler:handler];

}

// Deletes a queued transaction from the terminal.
-(void)deleteQueuedTransactionWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/queue/delete" gatewayPath:@"/api/queue/delete" method:@"POST" handler:handler];

}



// Captures a preauthorization.
-(void)captureWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/capture" method:@"POST" handler:handler];

}

// Discards a previous transaction.
-(void)voidWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/void" method:@"POST" handler:handler];

}

// Executes a manual time out reversal.
//
// We love time out reversals. Don't be afraid to use them whenever a request
// to a BlockChyp terminal times out. You have up to two minutes to reverse
// any transaction. The only caveat is that you must assign transactionRef
// values when you build the original request. Otherwise, we have no real way
// of knowing which transaction you're trying to reverse because we may not
// have assigned it an id yet. And if we did assign it an id, you wouldn't
// know what it is because your request to the terminal timed out before you
// got a response.
-(void)reverseWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/reverse" method:@"POST" handler:handler];

}

// Closes the current credit card batch.
-(void)closeBatchWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/close-batch" method:@"POST" handler:handler];

}

// Creates and send a payment link to a customer.
-(void)sendPaymentLinkWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/send-payment-link" method:@"POST" handler:handler];

}

// Retrieves the current status of a transaction.
-(void)transactionStatusWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/tx-status" method:@"POST" handler:handler];

}

// Updates or creates a customer record.
-(void)updateCustomerWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/update-customer" method:@"POST" handler:handler];

}

// Retrieves a customer by id.
-(void)customerWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/customer" method:@"POST" handler:handler];

}

// Searches the customer database.
-(void)customerSearchWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/customer-search" method:@"POST" handler:handler];

}

// Calculates the discount for actual cash transactions.
-(void)cashDiscountWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/cash-discount" method:@"POST" handler:handler];

}

// Returns the batch history for a merchant.
-(void)batchHistoryWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/batch-history" method:@"POST" handler:handler];

}

// Returns the batch details for a single batch.
-(void)batchDetailsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/batch-details" method:@"POST" handler:handler];

}

// Returns the transaction history for a merchant.
-(void)transactionHistoryWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/tx-history" method:@"POST" handler:handler];

}

// Returns profile information for a merchant.
-(void)merchantProfileWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/public-merchant-profile" method:@"POST" handler:handler];

}


@end


