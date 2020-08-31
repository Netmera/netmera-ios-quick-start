//
//  DeeplinkRouter.m
//  Netmera
//
//  Created by Nazire Aslan on 30/03/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import "DeeplinkRouter.h"
#import "AlertPresenter.h"

@interface DeeplinkRouter()

@property (nonatomic, weak) UIApplication *application;
@property (nonatomic, strong) AlertPresenter *alertPresenter;

@end


@implementation DeeplinkRouter

#pragma mark - initialize

- (instancetype)initWithApplication:(UIApplication *)application alertPresenter:(AlertPresenter *)alertPresenter {
  self = [super init];
  if (self) {
    _application = application;
    _alertPresenter = alertPresenter;
  }
  return self;
}

#pragma mark - Accessors

- (BOOL)handleURL:(NSURL *)url {
  [self.alertPresenter presentAlertWithTitle:@"Information" message:[url absoluteString]];
  return YES;
}

@end
