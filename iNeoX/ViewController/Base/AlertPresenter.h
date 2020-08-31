//
//  AlertPresenter.h
//  Netmera
//
//  Created by Yavuz Nuzumlali on 18/05/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertPresenter : NSObject

+ (void)setupDefaultPresenterWithApplication:(UIApplication *)application;
+ (instancetype)defaultPresenter;
- (instancetype)initWithApplication:(UIApplication *)application;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(NSInteger index))handler;

@end
