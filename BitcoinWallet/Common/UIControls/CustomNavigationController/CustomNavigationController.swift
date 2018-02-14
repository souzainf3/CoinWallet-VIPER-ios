//
//  CustomNavigationController.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 14/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    // MARK: - Initializers
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.commonInit()
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        self.commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    

    // MARK: - Private
    
    private func commonInit() {
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
        }
    }
}
