//
//  AppDelegate.swift
//  NetmeraSample
//
//  Created by inomera on 16.04.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit
import Netmera
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().delegate = self

        startNetmera()
        
        return true
    }
    
    func startNetmera() {
        Netmera.start()
//        Netmera.setBaseURL("YOUR_BASE_URL")
        Netmera.setAPIKey("SET_YOUR_API_KEY")
        Netmera.setAppGroupName("group.com.netmera.NetmeraSample")
        Netmera.setLogLevel(NetmeraLogLevel.debug)

        
        Netmera.requestPushNotificationAuthorization(forTypes: [.alert,.sound])
//        Netmera.setPushDelegate(self)
//        Netmera.setEnabledPopupPresentation(true)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Detect deeplink
        if let scheme = url.scheme, scheme == "netmeraSample" {
            // When you catch the deeplink you can access the parameters.
            // You can then do whatever you want here.
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //TODO
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        //TODO
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}

