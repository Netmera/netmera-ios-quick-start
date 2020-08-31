//
//  AppInfo.swift
//  iNeo
//
//  Created by inomera on 4.12.2019.
//  Copyright © 2019 Netmera. All rights reserved.
//

import Foundation

@objc public class AppInfo: NSObject {
    static var bundle: Bundle = Bundle.main
    
    public static let systemName = UIDevice.current.systemName
    public static let systemVersion = UIDevice.current.systemVersion
    public static let deviceModel = UIDevice.current.model
    public static let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    public static let screenSize = UIScreen.main.bounds.size
    public static let deviceName = UIDevice.current.name
    
    public static var appName: String {
        return self.bundle.infoDictionary!["CFBundleDisplayName" as String] as? String ?? ""
    }
    
    public static var appVersion: String {
        return self.bundle.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
    }
    
    public static var internalAppName: String {
        return self.bundle.infoDictionary!["BRInternalAppName"] as? String ?? ""
    }
    
    public static var buildVersion: String {
        return self.bundle.infoDictionary![kCFBundleVersionKey as String] as? String ?? ""
    }
  
}
