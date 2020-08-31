/*
 
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Provides details about a purchase. The purchase contains the product identifier, transaction id,
         and transaction date for a regular purchase. It includes the content identifier, content version,
         and content length for a hosted product. It contains the original transaction's id and date for
         a restored product.
 
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PaymentTransactionDetails : UITableViewController
@property (nonatomic, strong) NSArray *details;

@end

