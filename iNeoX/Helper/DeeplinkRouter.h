//
//  DeeplinkRouter.h
//  Netmera
//
//  Created by Nazire Aslan on 30/03/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlertPresenter;
@interface DeeplinkRouter : NSObject

- (instancetype)initWithApplication:(UIApplication *)application alertPresenter:(AlertPresenter *)alertPresenter;

- (BOOL)handleURL:(NSURL *)url;

@end
