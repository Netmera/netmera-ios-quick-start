//
//  BaseTableVC.h
//  Netmera
//
//  Created by Muhammed Yavuz Nuzumlali on 05/26/2015.
//  Copyright (c) 2014 Muhammed Yavuz Nuzumlali. All rights reserved.
//

#import "JSONHelper.h"
//#import "Pair.h"
#import <Netmera/Netmera.h>
#import "TextFieldCell.h"

@import UIKit;

extern NSString *const DefaultCellIdentifier;
extern NSString *const TextFieldCellIdentifier;

@interface BaseTableVC : UITableViewController

@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak, readonly) UIApplication *app;
@property (nonatomic, weak, readonly) NSObject<UIApplicationDelegate> *appDelegate;

- (void)configureDefaultCell:(UITableViewCell *)cell withData:(id)data;

@end
