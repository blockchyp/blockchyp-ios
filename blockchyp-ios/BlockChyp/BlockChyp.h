// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

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

// Returns a list of queued transactions on a terminal.
-(void)listQueuedTransactionsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Deletes a queued transaction from the terminal.
-(void)deleteQueuedTransactionWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;



// Returns routing and location data for a payment terminal.
-(void)locateWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Captures a preauthorization.
-(void)captureWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Discards a previous transaction.
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

// Cancels a payment link.
-(void)cancelPaymentLinkWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

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

// Deletes a customer record.
-(void)deleteCustomerWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Retrieves payment token metadata.
-(void)tokenMetadataWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Links a token to a customer record.
-(void)linkTokenWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Removes a link between a customer and a token.
-(void)unlinkTokenWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Deletes a payment token.
-(void)deleteTokenWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;



// Adds a test merchant account.
-(void)getMerchantsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Adds or updates a merchant account. Can be used to create or update test
// merchants. Only gateway only partners may create new live merchants.
-(void)updateMerchantWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// List all active users and pending invites for a merchant account.
-(void)merchantUsersWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Invites a user to join a merchant account.
-(void)inviteMerchantUserWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Adds a test merchant account.
-(void)addTestMerchantWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Deletes a test merchant account. Supports partner scoped API credentials
// only. Live merchant accounts cannot be deleted.
-(void)deleteTestMerchantWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// List all merchant platforms configured for a gateway merchant.
-(void)merchantPlatformsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// List all merchant platforms configured for a gateway merchant.
-(void)updateMerchantPlatformsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Deletes a boarding platform configuration.
-(void)deleteMerchantPlatformsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns all terminals associated with the merchant account.
-(void)terminalsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Deactivates a terminal.
-(void)deactivateTerminalWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Activates a terminal.
-(void)activateTerminalWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns a list of terms and conditions templates associated with a merchant
// account.
-(void)tcTemplatesWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns a single terms and conditions template.
-(void)tcTemplateWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Updates or creates a terms and conditions template.
-(void)tcUpdateTemplateWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Deletes a single terms and conditions template.
-(void)tcDeleteTemplateWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns up to 250 entries from the Terms and Conditions log.
-(void)tcLogWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns a single detailed Terms and Conditions entry.
-(void)tcEntryWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns all survey questions for a given merchant.
-(void)surveyQuestionsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns a single survey question with response data.
-(void)surveyQuestionWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Updates or creates a survey question.
-(void)updateSurveyQuestionWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Deletes a survey question.
-(void)deleteSurveyQuestionWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns results for a single survey question.
-(void)surveyResultsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns the media library for a given partner, merchant, or organization.
-(void)mediaWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Uploads a media asset to the media library.
-(void)uploadMediaWithRequest:(NSDictionary *)request content:(NSData*)content handler:(BlockChypCompletionHandler)handler;

// Retrieves the current status of a file upload.
-(void)uploadStatusWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns the media details for a single media asset.
-(void)mediaAssetWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Deletes a media asset.
-(void)deleteMediaAssetWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns a collection of slide shows.
-(void)slideShowsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns a single slide show with slides.
-(void)slideShowWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Updates or creates a slide show.
-(void)updateSlideShowWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Deletes a single slide show.
-(void)deleteSlideShowWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Returns the terminal branding stack for a given set of API credentials.
-(void)terminalBrandingWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Updates a branding asset.
-(void)updateBrandingAssetWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;

// Deletes a branding asset.
-(void)deleteBrandingAssetWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler;


@end

NS_ASSUME_NONNULL_END

