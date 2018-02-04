
//
//  TabBarWireframe.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation
import UIKit


protocol TabBarInterface {
    func configuredViewController() -> UIViewController
}

class TabBarWireframe {
    
    let wireFrames: [TabBarInterface]
    
    private(set) weak var tabBarController: UITabBarController?

    
    init(_ wireFrames: TabBarInterface...) {
        self.wireFrames = wireFrames
    }
    
    private init() {
        self.wireFrames = [TabBarInterface]()
    }
    
    func installInto(window: UIWindow) {
        let tabBar = UITabBarController()
        tabBar.viewControllers = wireFrames.map({ $0.configuredViewController() })
        window.rootViewController = tabBar
    }
}


