//
//  FirebaseViewController.m
//  iNeoX
//
//  Created by inomera on 6.10.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

#import "FirebaseViewController.h"
#import <FirebaseAnalytics/FirebaseAnalytics.h>

@implementation FirebaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:self
                                                                           action:@selector(submit)];
  self.cellIdentifier = TextFieldCellIdentifier;
  self.dataSource = @[@"ScreenId", @"PageId", @"ReferrerPageName", @"TimeInPage", @"ScreenId", @"Keywords"];
    
//    NetmeraCartViewEvent *event = [NetmeraCartViewEvent event];
//    NSLog(event.dictionaryValue);
    
    [FIRAnalytics logEventWithName:kFIREventAddToCart parameters:@{
    kFIRParameterItemID:@"product-id-XXX",
    kFIRParameterItemName:@"product-name",
    kFIRParameterPrice: @(220),
    kFIRParameterItemBrand: @"product-brand",
    kFIRParameterItemVariant: @"product-variant",
    kFIRParameterQuantity: @(3)
    }];
}

- (void)submit {
    // Define products with relevant parameters.
    NSDictionary *product1 = @{
       kFIRParameterItemID : @"sku1234", // ITEM_ID or ITEM_NAME is required.
       kFIRParameterItemName : @"Android Jogger Sweatpants",
       kFIRParameterItemCategory : @"Apparel/Men/Pants",
       kFIRParameterItemVariant : @"Blue",
       kFIRParameterItemBrand : @"Google",
       kFIRParameterPrice : @39.99,
       kFIRParameterCurrency : @"USD",  // Item-level currency unused today.
       kFIRParameterQuantity : @1
    };

    NSDictionary *product2 = @{
       kFIRParameterItemID : @"sku5678", // ITEM_ID or ITEM_NAME is required.
       kFIRParameterItemName : @"Android Capri",
       kFIRParameterItemCategory : @"Apparel/Women/Pants",
       kFIRParameterItemVariant : @"Black",
       kFIRParameterItemBrand : @"Google",
       kFIRParameterPrice : @35.99,
       kFIRParameterCurrency : @"USD",  // Item-level currency unused today.
       kFIRParameterQuantity : @1
    };

    // Prepare ecommerce dictionary.
    NSArray *items = @[product1, product2];

    NSDictionary *ecommerce = @{
       @"items" : items,
       kFIRParameterItemList : @"Search Results", // List name.
       kFIRParameterTransactionID : @"T12345",
       kFIRParameterAffiliation : @"Google Store - Online",
       kFIRParameterValue : @75.98, // Revenue.
       kFIRParameterTax : @3.80,
       kFIRParameterShipping : @5.34,
       kFIRParameterCurrency : @"USD",
       kFIRParameterCoupon : @"SUMMER2017"
    };

    // Log ecommerce_purchase event with ecommerce dictionary.
    [FIRAnalytics logEventWithName:kFIREventEcommercePurchase
                        parameters:ecommerce];
}
@end
