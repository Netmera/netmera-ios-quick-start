//
//  ViewController.swift
//  NetmeraSample
//
//  Created by inomera on 16.04.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit
import Netmera

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Netmera Quick Start"
    }

    @IBAction func touchedNotificationButton(_ sender: Any) {
        Netmera.requestPushNotificationAuthorization(forTypes: [.alert,.sound])
    }
    
    @IBAction func touchedLocationButton(_ sender: Any) {
        Netmera.requestLocationAuthorization()
    }
    
    @IBAction func touchedInboxButton(_ sender: Any) {
        let inboxViewController = InboxViewController(nibName: "InboxViewController", bundle: nil)
        navigationController?.pushViewController(inboxViewController, animated: true)
    }

}

