//
//  NetmeraEventsVC.m
//  iNeo
//
//  Created by inomera on 20.05.2019.
//  Copyright © 2019 Netmera. All rights reserved.
//

#import "NetmeraEventsVC.h"
#import "ScreenEventVC.h"
#import "FormTableViewController.h"

@interface NetmeraEventsVC ()

@end

@implementation NetmeraEventsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
  self.dataSource = @[
                      [ScreenEventVC class],
                      [FormTableViewController class]
                      ];
}

@end
