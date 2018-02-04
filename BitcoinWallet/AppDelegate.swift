//
//  AppDelegate.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit
import IQKeyboardManager


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var appWireframe: AppWireframe!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared().isEnabled = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.appWireframe = AppWireframe(window: self.window!)
        self.appWireframe.installRootViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

