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

        
        // TODO: - Mock, remova daqui
        if !UserDefaults.standard.bool(forKey: "bitcoinWallet.mock.injected") {
            let wallet = Wallet(currency: .real, amount: 100000)
            WalletDataManager(database: DatabaseManager()).updateWallet(wallet)
            UserDefaults.standard.set(true, forKey: "bitcoinWallet.mock.injected")
        }
        
        
        IQKeyboardManager.shared().isEnabled = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.appWireframe = AppWireframe(window: self.window!)
        self.appWireframe.installRootViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

