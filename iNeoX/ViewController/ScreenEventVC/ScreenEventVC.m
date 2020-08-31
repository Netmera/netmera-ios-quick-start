//
//  ScreenEventVC.m
//  iNeo
//
//  Created by inomera on 20.05.2019.
//  Copyright © 2019 Netmera. All rights reserved.
//

#import "ScreenEventVC.h"
#import <Netmera/Netmera.h>

@interface ScreenEventVC ()

@end

@implementation ScreenEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:self
                                                                           action:@selector(submit)];
  self.cellIdentifier = TextFieldCellIdentifier;
  self.dataSource = @[@"ScreenId", @"PageId", @"ReferrerPageName", @"TimeInPage", @"ScreenId", @"Keywords"];
}

- (void)submit {
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  for (TextFieldCell *cell in [self.tableView visibleCells]) {
    dict[cell.textField.placeholder] = cell.textField.text;
  };
  
  NetmeraScreenViewEvent *screen = [NetmeraScreenViewEvent eventWithId:dict[@"ScreenId"] referrerPageId:dict[@"PageId"] referrerPageName:dict[@"ReferrerPageName"] timeInPage:[dict[@"TimeInPage"] doubleValue] pageName:dict[@"ScreenId"]];
  NSString *keywordsString = dict[@"Keywords"];
  NSArray *keywords = [keywordsString componentsSeparatedByString:@","];
  [screen setKeywords:keywords];
  [Netmera sendEvent:screen];
}


@end
