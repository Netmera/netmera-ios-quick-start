//
//  ViewController.swift
//  NetmeraSample
//
//  Created by inomera on 16.04.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Netmera Quick Start"
    }

    @IBAction func touchedInboxButton(_ sender: Any) {
        let inboxViewController = InboxViewController(nibName: "InboxViewController", bundle: nil)
        navigationController?.pushViewController(inboxViewController, animated: true)
    }

}

