/*
 
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Model class to represent a product/purchase.
 
*/

#import <Foundation/Foundation.h>

@interface PurchaseModel : NSObject

// Products/Purchases are organized by category
@property (nonatomic, copy) NSString *name;
//  List of products/purchases
@property (nonatomic, strong) NSArray *elements;

// Create a model object
-(instancetype)initWithName:(NSString *)name elements:(NSArray *)elements NS_DESIGNATED_INITIALIZER;

@end
