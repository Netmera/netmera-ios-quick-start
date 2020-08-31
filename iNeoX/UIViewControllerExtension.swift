//
//  UIViewControllerExtension.swift
//  iNeo
//
//  Created by inomera on 30.07.2019.
//  Copyright © 2019 Netmera. All rights reserved.
//

import Foundation

extension UIViewController {
  
  func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Kapat", style: .cancel, handler: nil))
    self.present(alert, animated: true)
  }
}
