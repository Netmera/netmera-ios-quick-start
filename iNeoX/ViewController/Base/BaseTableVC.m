//
//  BaseTableVC.m
//  Netmera
//
//  Created by Muhammed Yavuz Nuzumlali on 05/26/2015.
//  Copyright (c) 2014 Muhammed Yavuz Nuzumlali. All rights reserved.
//

#import "BaseTableVC.h"

NSString *const DefaultCellIdentifier = @"DefaultCell";
NSString *const TextFieldCellIdentifier = @"TextFieldCell";

@interface BaseTableVC ()

@end

@implementation BaseTableVC

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = NSStringFromClass([self class]);
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DefaultCellIdentifier];
  [self.tableView registerClass:[TextFieldCell class] forCellReuseIdentifier:TextFieldCellIdentifier];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self dataSource].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *cellIdentifier = self.cellIdentifier ? : DefaultCellIdentifier;

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
  id data = self.dataSource[indexPath.row];
  if([cellIdentifier isEqualToString:TextFieldCellIdentifier]) {
    [self configureTextFieldCell:(TextFieldCell *)cell withData:data];
  } else if([cellIdentifier isEqualToString:DefaultCellIdentifier]) {
    [self configureDefaultCell:cell withData:data];
  }
  return cell;
}

- (void)configureTextFieldCell:(TextFieldCell *)cell withData:(NSString *)data {
  NSParameterAssert([data isKindOfClass:[NSString class]]);
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textField.placeholder = data;
}

- (void)configureDefaultCell:(UITableViewCell *)cell withData:(id)data {
  NSParameterAssert(([data class] == data && [data isSubclassOfClass:[UIViewController class]]) ||
                    [data isKindOfClass:[NSString class]]);

  NSString *text;
  if ([data class] == data) {
    // Data is a Class type
    text = NSStringFromClass(data);
  } else if ([data isKindOfClass:[NSString class]]){
    text = data;
  }
  cell.textLabel.text = text;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if([self.cellIdentifier isEqualToString:TextFieldCellIdentifier]) {
    return;
  }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  id data = self.dataSource[indexPath.row];

  if ([data isKindOfClass:[NSString class]]) {
    // Treat it as a selector string
    [self performSelector:NSSelectorFromString(data)];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  } else if ([data class] == data) {
    UIViewController *vc = [[(Class)data alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
  }
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
#pragma clang diagnostic pop
}

- (UIApplication *)app {
  return [UIApplication sharedApplication];
}

- (NSObject<UIApplicationDelegate> *)appDelegate {
  return self.app.delegate;
}

@end
