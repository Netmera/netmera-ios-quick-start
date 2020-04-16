//
//  NotificationService.swift
//  NetmeraSampleNotificationServiceExtension
//
//  Created by inomera on 16.04.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UserNotifications

class NotificationService:  NetmeraNotificationServiceExtension {

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (_ contentToDeliver: UNNotificationContent) -> Void) {
        super.didReceive(request, withContentHandler: contentHandler)
    }
    
    override func serviceExtensionTimeWillExpire() {
        super.serviceExtensionTimeWillExpire()
    }

}
