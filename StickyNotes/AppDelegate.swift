//
//  AppDelegate.swift
//  StickyNotes
//
//  Created by SARVJEETSINGH on 15/08/20.
//  Copyright © 2020 SARVJEETSINGH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Saving the data changes available in mainContext to the persistance storage
        CoreDataStack.shared.saveContext()
    }

    // MARK: UISceneSession Lifecycle    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

