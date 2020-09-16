//
//  UserUpdateVC.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 21/04/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import "UserUpdateVC.h"

@implementation UserUpdateVC

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:self
                                                                           action:@selector(submit)];
  self.cellIdentifier = TextFieldCellIdentifier;
  self.dataSource = @[@"Name", @"Surname", @"Email", @"UserId", @"MSISDN"];
}

- (void)submit {
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  for (TextFieldCell *cell in [self.tableView visibleCells]) {
    dict[cell.textField.placeholder] = cell.textField.text;
  };
  NetmeraUser *user = [[NetmeraUser alloc] init];
  user.userId = dict[@"UserId"];
  user.name = dict[@"Name"];
  user.surname = dict[@"Surname"];
  user.email = dict[@"Email"];
  user.MSISDN = dict[@"MSISDN"];
  [Netmera updateUser:user];
    
    [Netmera sendEvent:[NetmeraScreenViewEvent eventWithId:@"deneme" referrerPageId:@"pageId" referrerPageName:@"name" timeInPage:10.0 pageName:@""]];
    
    [Netmera sendEvent:[NetmeraScreenViewEvent eventWithId:@"deneme2" referrerPageId:@"pageId" referrerPageName:@"name" timeInPage:10.0 pageName:@""]];
    [Netmera sendEvent:[NetmeraScreenViewEvent eventWithId:@"deneme3" referrerPageId:@"pageId" referrerPageName:@"name" timeInPage:10.0 pageName:@""]];
    [Netmera sendEvent:[NetmeraScreenViewEvent eventWithId:@"deneme4" referrerPageId:@"pageId" referrerPageName:@"name" timeInPage:10.0 pageName:@""]];
    [Netmera sendEvent:[NetmeraScreenViewEvent eventWithId:@"deneme5" referrerPageId:@"pageId" referrerPageName:@"name" timeInPage:10.0 pageName:@""]];



}


@end
