//
//  FormTableViewController.m
//  iNeo
//
//  Created by inomera on 23.12.2019.
//  Copyright © 2019 Netmera. All rights reserved.
//

#import "FormTableViewController.h"

@interface FormTableViewController ()

@end

@implementation FormTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.title = @"Register";

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:self
                                                                           action:@selector(submit)];
  self.cellIdentifier = TextFieldCellIdentifier;
  self.dataSource = @[@"Email", @"Firstname", @"Surname", @"Username", @"City", @"Adress", @"Job"];
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  self.title = @"Register";
}

- (void)submit {
  [self.navigationController popViewControllerAnimated:true];
}

@end
