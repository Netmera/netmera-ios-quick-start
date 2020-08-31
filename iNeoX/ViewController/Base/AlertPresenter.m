//
//  AlertPresenter.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 18/05/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import "AlertPresenter.h"

@interface AlertPresenter()

@property (nonatomic, weak) UIApplication *application;
@property (nonatomic, copy) void (^handler)(NSInteger index);

@end

@implementation AlertPresenter

- (instancetype)initWithApplication:(UIApplication *)application
{
  self = [super init];
  if (self)
  {
    _application = application;
  }
  return self;
}


static AlertPresenter *__presenter;
+ (void)setupDefaultPresenterWithApplication:(UIApplication *)application {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    __presenter = [[AlertPresenter alloc] initWithApplication:application];
  });
}

+ (instancetype)defaultPresenter {
  return __presenter;
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
  [self presentAlertWithTitle:title message:message handler:nil];
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(NSInteger))handler {
  UIAlertController *ac  = [UIAlertController alertControllerWithTitle:title
                                                               message:message
                                                        preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
    if (handler) {
      handler([ac.actions indexOfObject:action]);
    }
  }];
  [ac addAction:OKAction];
  UIViewController *rootVC = self.application.keyWindow.rootViewController;
  [rootVC presentViewController:ac animated:YES completion:nil];
}

@end
