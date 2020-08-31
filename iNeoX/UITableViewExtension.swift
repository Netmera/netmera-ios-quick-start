//
//  UITableViewExtension.swift
//  iNeo
//
//  Created by inomera on 30.07.2019.
//  Copyright © 2019 Netmera. All rights reserved.
//

import Foundation
import UIKit

public protocol CellProtocol: class {
  associatedtype Model
  func config(_ data: Model?)
}

open class BaseCell: UITableViewCell {
  public func config(_ data: Any?) {}
}

extension UITableView {
  
  func registerReusableCell<T: BaseCell>(type: T.Type) {
    //        register(T.self, forCellReuseIdentifier: T.identifier)
    print("nib: \(String(describing: type)) identifier: \(String(describing: type))Identifier")
    register(UINib(nibName: String(describing: type), bundle: nil), forCellReuseIdentifier: "\(String(describing: type))Identifier")
  }
  
  func registerReusableCell<T: CellProtocol>(type: T.Type) {
    //        register(T.self, forCellReuseIdentifier: T.identifier)
    print("nib: \(String(describing: type)) identifier: \(String(describing: type))Identifier")
    register(UINib(nibName: String(describing: type), bundle: nil), forCellReuseIdentifier: "\(String(describing: type))Identifier")
  }
  
  func dequeueReusableCell<T: CellProtocol>(type: T.Type, indexPath: IndexPath) -> T {
    print("dequeu identifier: \(String(describing: T.self))Identifier")
    return dequeueReusableCell(withIdentifier: "\(String(describing: type))Identifier", for: indexPath) as! T
  }
  
  func dequeueReusableCell<T: BaseCell>(type: T.Type, indexPath: IndexPath) -> T {
    print("dequeu identifier: \(String(describing: T.self))Identifier")
    return dequeueReusableCell(withIdentifier: "\(String(describing: type))Identifier", for: indexPath) as! T
  }
}
