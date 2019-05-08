//
//  AppDelegate.swift
//  CoreStoreUpdate
//
//  Created by Alex Matrosov on 5/8/19.
//  Copyright © 2019 Alex Matrosov. All rights reserved.
//

import UIKit
import CoreStore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        try! CoreStore.addStorageAndWait(SQLiteStore())
        
        return true
    }
}

