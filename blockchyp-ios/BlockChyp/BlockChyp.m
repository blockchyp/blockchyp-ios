// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

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

  [self routeTerminalRequestWith:request terminalPath:@"/api/queue/list" gatewayPath:@"/api/queue/list" method:@"POST" handler:handler];

}

// Deletes a queued transaction from the terminal.
-(void)deleteQueuedTransactionWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/queue/delete" gatewayPath:@"/api/queue/delete" method:@"POST" handler:handler];

}

// Reboot a payment terminal.
-(void)rebootWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler; {

  [self routeTerminalRequestWith:request terminalPath:@"/api/reboot" gatewayPath:@"/api/terminal-reboot" method:@"POST" handler:handler];

}



// Returns routing and location data for a payment terminal.
-(void)locateWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/terminal-locate" method:@"POST" handler:handler];

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

// Cancels a payment link.
-(void)cancelPaymentLinkWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/cancel-payment-link" method:@"POST" handler:handler];

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

// Deletes a customer record.
-(void)deleteCustomerWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:[@"/api/customer/" stringByAppendingString:[request objectForKey:@"customerId"]] method:@"DELETE" handler:handler];

}

// Retrieves payment token metadata.
-(void)tokenMetadataWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:[@"/api/token/" stringByAppendingString:[request objectForKey:@"token"]] method:@"GET" handler:handler];

}

// Links a token to a customer record.
-(void)linkTokenWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/link-token" method:@"POST" handler:handler];

}

// Removes a link between a customer and a token.
-(void)unlinkTokenWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:@"/api/unlink-token" method:@"POST" handler:handler];

}

// Deletes a payment token.
-(void)deleteTokenWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeGatewayRequestWith:request path:[@"/api/token/" stringByAppendingString:[request objectForKey:@"token"]] method:@"DELETE" handler:handler];

}



// Adds a test merchant account.
-(void)getMerchantsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/get-merchants" method:@"POST" handler:handler];

}


// Adds or updates a merchant account. Can be used to create or update test
// merchants. Only gateway only partners may create new live merchants.
-(void)updateMerchantWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/update-merchant" method:@"POST" handler:handler];

}


// List all active users and pending invites for a merchant account.
-(void)merchantUsersWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/merchant-users" method:@"POST" handler:handler];

}


// Invites a user to join a merchant account.
-(void)inviteMerchantUserWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/invite-merchant-user" method:@"POST" handler:handler];

}


// Adds a test merchant account.
-(void)addTestMerchantWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/add-test-merchant" method:@"POST" handler:handler];

}


// Deletes a test merchant account. Supports partner scoped API credentials
// only. Live merchant accounts cannot be deleted.
-(void)deleteTestMerchantWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/test-merchant/" stringByAppendingString:[request objectForKey:@"merchantId"]] method:@"DELETE" handler:handler];

}


// List all merchant platforms configured for a gateway merchant.
-(void)merchantPlatformsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/plugin-configs/" stringByAppendingString:[request objectForKey:@"merchantId"]] method:@"GET" handler:handler];

}


// List all merchant platforms configured for a gateway merchant.
-(void)updateMerchantPlatformsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/plugin-configs" method:@"POST" handler:handler];

}


// Deletes a boarding platform configuration.
-(void)deleteMerchantPlatformsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/plugin-config/" stringByAppendingString:[request objectForKey:@"platformId"]] method:@"DELETE" handler:handler];

}


// Returns all terminals associated with the merchant account.
-(void)terminalsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/terminals" method:@"GET" handler:handler];

}


// Deactivates a terminal.
-(void)deactivateTerminalWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/terminal/" stringByAppendingString:[request objectForKey:@"terminalId"]] method:@"DELETE" handler:handler];

}


// Activates a terminal.
-(void)activateTerminalWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/terminal-activate" method:@"POST" handler:handler];

}


// Returns a list of terms and conditions templates associated with a merchant
// account.
-(void)tcTemplatesWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/tc-templates" method:@"GET" handler:handler];

}


// Returns a single terms and conditions template.
-(void)tcTemplateWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/tc-templates/" stringByAppendingString:[request objectForKey:@"templateId"]] method:@"GET" handler:handler];

}


// Updates or creates a terms and conditions template.
-(void)tcUpdateTemplateWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/tc-templates" method:@"POST" handler:handler];

}


// Deletes a single terms and conditions template.
-(void)tcDeleteTemplateWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/tc-templates/" stringByAppendingString:[request objectForKey:@"templateId"]] method:@"DELETE" handler:handler];

}


// Returns up to 250 entries from the Terms and Conditions log.
-(void)tcLogWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/tc-log" method:@"POST" handler:handler];

}


// Returns a single detailed Terms and Conditions entry.
-(void)tcEntryWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/tc-entry/" stringByAppendingString:[request objectForKey:@"logEntryId"]] method:@"GET" handler:handler];

}


// Returns all survey questions for a given merchant.
-(void)surveyQuestionsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/survey-questions" method:@"GET" handler:handler];

}


// Returns a single survey question with response data.
-(void)surveyQuestionWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/survey-questions/" stringByAppendingString:[request objectForKey:@"questionId"]] method:@"GET" handler:handler];

}


// Updates or creates a survey question.
-(void)updateSurveyQuestionWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/survey-questions" method:@"POST" handler:handler];

}


// Deletes a survey question.
-(void)deleteSurveyQuestionWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/survey-questions/" stringByAppendingString:[request objectForKey:@"questionId"]] method:@"DELETE" handler:handler];

}


// Returns results for a single survey question.
-(void)surveyResultsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/survey-results" method:@"POST" handler:handler];

}


// Returns the media library for a given partner, merchant, or organization.
-(void)mediaWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/media" method:@"GET" handler:handler];

}


// Uploads a media asset to the media library.
-(void)uploadMediaWithRequest:(NSDictionary *)request content:(NSData *)content handler:(BlockChypCompletionHandler)handler  {

  [self routeUploadRequestWith:request path:@"/api/upload-media" content:content handler:handler];

}


// Retrieves the current status of a file upload.
-(void)uploadStatusWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/media-upload/" stringByAppendingString:[request objectForKey:@"uploadId"]] method:@"GET" handler:handler];

}


// Returns the media details for a single media asset.
-(void)mediaAssetWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/media/" stringByAppendingString:[request objectForKey:@"mediaId"]] method:@"GET" handler:handler];

}


// Deletes a media asset.
-(void)deleteMediaAssetWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/media/" stringByAppendingString:[request objectForKey:@"mediaId"]] method:@"DELETE" handler:handler];

}


// Returns a collection of slide shows.
-(void)slideShowsWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/slide-shows" method:@"GET" handler:handler];

}


// Returns a single slide show with slides.
-(void)slideShowWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/slide-shows/" stringByAppendingString:[request objectForKey:@"slideShowId"]] method:@"GET" handler:handler];

}


// Updates or creates a slide show.
-(void)updateSlideShowWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/slide-shows" method:@"POST" handler:handler];

}


// Deletes a single slide show.
-(void)deleteSlideShowWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/slide-shows/" stringByAppendingString:[request objectForKey:@"slideShowId"]] method:@"DELETE" handler:handler];

}


// Returns the terminal branding stack for a given set of API credentials.
-(void)terminalBrandingWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/terminal-branding" method:@"GET" handler:handler];

}


// Updates a branding asset.
-(void)updateBrandingAssetWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:@"/api/terminal-branding" method:@"POST" handler:handler];

}


// Deletes a branding asset.
-(void)deleteBrandingAssetWithRequest:(NSDictionary *)request handler:(BlockChypCompletionHandler)handler {

  [self routeDashboardRequestWith:request path:[@"/api/terminal-branding/" stringByAppendingString:[request objectForKey:@"assetId"]] method:@"DELETE" handler:handler];

}



@end


