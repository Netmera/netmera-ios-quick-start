//
//  LocationVC.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 30/12/15.
//  Copyright © 2015 Netmera. All rights reserved.
//

#import "LocationVC.h"

@interface LocationVC ()

@end

@implementation LocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
  self.dataSource = @[ NSStringFromSelector(@selector(enableLocationTracking))];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enableLocationTracking {
  [Netmera requestLocationAuthorization];
}

@end
