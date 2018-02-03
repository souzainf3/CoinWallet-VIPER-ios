//
//  RootWireframe.swift
//  EscolarResponsavel
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation
import UIKit


class AppWireframe: NSObject {
    
    // MARK: Properties
    private(set) weak var window: UIWindow!
    private(set) weak var tabBarController: UITabBarController?
    
    
    // MARK: Public
    
    init(window: UIWindow) {
        super.init()
        
        self.window = window
    }
    
    func installRootViewController() {
    }

}


