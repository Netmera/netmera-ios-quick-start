//
//  NotificationService.m
//  NotificationService
//
//  Created by inomera on 1.09.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent *contentToDeliver))contentHandler {
    [super didReceiveNotificationRequest:request withContentHandler:contentHandler];
}

- (void)serviceExtensionTimeWillExpire {
    [super serviceExtensionTimeWillExpire];
}

@end
