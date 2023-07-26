//
//  NotificationViewController.swift
//  NetmeraSampleNotificationContentExtension
//
//  Created by inomera on 16.04.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import NetmeraNotificationContentExtension

class NotificationViewController: NetmeraNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
