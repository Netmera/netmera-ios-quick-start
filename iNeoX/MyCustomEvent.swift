//
//  MyCustomEvent.swift
//  iNeoX
//
//  Created by inomera on 21.10.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import Foundation

let kMyCustomEventKey: String = "gxh"

class MyCustomEvent: NetmeraEvent {
    
    @objc var testIntArray: [Int] = []
    @objc var title: String = ""
    @objc var testInt: Int = 0
    @objc var testNumber: NSNumber?
    @objc var testString: String?

    override class func keyPathPropertySelectorMapping() -> [AnyHashable: Any] {
        return[
            "eo": NSStringFromSelector(#selector(getter: self.testIntArray)),
            "eb": NSStringFromSelector(#selector(getter: self.title)),
            "ec": NSStringFromSelector(#selector(getter: self.testInt)),
            "ed": NSStringFromSelector(#selector(getter: self.testNumber)),
            "es": NSStringFromSelector(#selector(getter: self.testString))
        ]
    }

    override var eventKey : String {
        return kMyCustomEventKey
    }
}
