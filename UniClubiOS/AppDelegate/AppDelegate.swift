//
//  AppDelegate.swift
//  UniClubiOS
//
//  Created by Daniyar on 10/16/20.
//

import UIKit
import AlamofireEasyLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let reachibilityHandler = ReachabilityHandler()
    let alamofireLogger = FancyAppAlamofireLogger(
        logFunction: {
            print($0)
        }
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let cart = ModuleUserDefaults.getCart(){
            AppShared.sharedInstance.cart = cart
        } else {
            AppShared.sharedInstance.cart = Cart(items: [])
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

