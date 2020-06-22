//
//  BlockChyp.h
//  blockchyp-ios
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockChypClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlockChyp : BlockChypClient

-(void)heartbeat:(BOOL)test handler:(BlockChypGetCompletionHandler)handler;


// Tests connectivity with a payment terminal.
-(void)pingWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Executes a standard direct preauth and capture.
-(void)chargeWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Executes a preauthorization intended to be captured later.
-(void)preauthWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Executes a refund.
-(void)refundWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Adds a new payment method to the token vault.
-(void)enrollWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Activates or recharges a gift card.
-(void)giftActivateWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Checks the remaining balance on a payment method.
-(void)balanceWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Clears the line item display and any in progress transaction.
-(void)clearWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns the current status of a terminal.
-(void)terminalStatusWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Prompts the user to accept terms and conditions.
-(void)termsAndConditionsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Captures and returns a signature.
-(void)captureSignatureWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Displays a new transaction on the terminal.
-(void)newTransactionDisplayWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Appends items to an existing transaction display. Subtotal, Tax, and Total
// are overwritten by the request. Items with the same description are
// combined into groups.
-(void)updateTransactionDisplayWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Displays a short message on the terminal.
-(void)messageWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Asks the consumer a yes/no question.
-(void)booleanPromptWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Asks the consumer a text based question.
-(void)textPromptWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;



// Captures a preauthorization.
-(void)captureWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Discards a previous preauth transaction.
-(void)voidWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

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
-(void)reverseWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Closes the current credit card batch.
-(void)closeBatchWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Creates and send a payment link to a customer.
-(void)sendPaymentLinkWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Retrieves the current status of a transaction.
-(void)transactionStatusWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Updates or creates a customer record.
-(void)updateCustomerWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Retrieves a customer by id.
-(void)customerWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Searches the customer database.
-(void)customerSearchWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Calculates the discount for actual cash transactions.
-(void)cashDiscountWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns the batch history for a merchant.
-(void)batchHistoryWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns the batch details for a single batch.
-(void)batchDetailsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns the transaction history for a merchant.
-(void)transactionHistoryWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns profile information for a merchant.
-(void)merchantProfileWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;


@end

NS_ASSUME_NONNULL_END

