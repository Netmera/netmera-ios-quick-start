//
//  MainVC.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 30/12/15.
//  Copyright © 2015 Netmera. All rights reserved.
//

#import "MainVC.h"
#import "PushVC.h"
#import "LocationVC.h"
#import "RestPushVC.h"
#import "UserUpdateVC.h"
#import <Netmera/Netmera.h>
#import "NetmeraEventsVC.h"
#import "iNeoX-Swift.h"
#import "InAppPurchaseViewController.h"
#import "CrashesObjViewController.h"

@interface Netmera ()

+ (instancetype)instance;
- (NSAttributedString *)attributedDebugDescription;

@end

@interface MainVC ()

@property (nonatomic, strong) UITextView * footerTextView;
@end

@implementation MainVC

- (void)viewDidLoad {
  [super viewDidLoad];
  self.dataSource = @[
                      [PushVC class],
                      [LocationVC class],
                      [RestPushVC class],
                      [UserUpdateVC class],
                      [NetmeraEventsVC class],
                      [InboxViewController class],
                      [InboxCategoryViewController class],
                      [InAppPurchaseViewController class],
                      [ControlsViewController class],
                      [MapViewController class],
                      [CrashesObjViewController class],
                      [CrashesSwiftViewController class],
                      NSStringFromSelector(@selector(addToTestDevices)),
                      ];
  [self configureFooterView];
  
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  NetmeraScreenViewEvent *screen = [NetmeraScreenViewEvent eventWithId:@"MainVC" referrerPageId:@"asd" referrerPageName:@"xxx" timeInPage:100.0 pageName:@"deneme"];
  [Netmera sendEvent:screen];
}

- (void)viewWillAppear:(BOOL)animated {
//  [self configureFooterView];
}

- (NSAttributedString *)attributedDebugDescription {
  NSMutableAttributedString *description = [[NSMutableAttributedString alloc] init];
  NSDictionary *headAttributes = @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
                                   NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)};
  NSDictionary *bodyAttributes = @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};

  NSAttributedString *attributedBuildNumHeader = [[NSAttributedString alloc] initWithString:@"Build Number\n"
                                                                                 attributes:headAttributes];
  [description appendAttributedString:attributedBuildNumHeader];
  NSString *buildNum = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
  NSAttributedString *attributedBuildNum = [[NSAttributedString alloc] initWithString:buildNum
                                                                           attributes:bodyAttributes];
  [description appendAttributedString:attributedBuildNum];
  if ([Netmera instance]) {
    [description appendAttributedString:[[Netmera instance] attributedDebugDescription]];
  }
  
//  NSAttributedString *attributedIPNumHeader = [[NSAttributedString alloc] initWithString:@"\nDEVICE IP\n" attributes:headAttributes];
//
//  [description appendAttributedString:attributedIPNumHeader];
//
//  NSAttributedString *attributedIPNum = [[NSAttributedString alloc] initWithString:[AppInfo getIPAddress2] attributes:bodyAttributes];
//
//  [description appendAttributedString:attributedIPNum];
  
//  NSLog(@"%@", [AppInfo getIPAddress2]);
  return [description copy];
}

- (void)configureFooterView {
  if (!self.footerTextView) {
    UITextView *footer = [[UITextView alloc] init];
    footer.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    footer.backgroundColor = [UIColor clearColor];
    footer.editable = NO;
    footer.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.tableView.tableFooterView = footer;
    self.footerTextView = footer;
  }
  self.footerTextView.attributedText = [self attributedDebugDescription];
  CGRect bounds = CGRectZero;
  bounds.size = CGSizeMake(CGRectGetWidth(self.tableView.bounds), 10000);
  self.footerTextView.frame = bounds;
  [self.footerTextView sizeToFit];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)addToTestDevices {
  NSURL *URL = [NSURL URLWithString:@"netmera://_netmera?queryString"];
  [self.appDelegate application:self.app openURL:URL options:@{}];
}

@end
