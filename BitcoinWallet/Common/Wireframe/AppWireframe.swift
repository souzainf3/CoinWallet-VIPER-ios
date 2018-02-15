//
//  RootWireframe.swift
//  EscolarResponsavel
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation
import UIKit

class AppWireframe {
    
    // MARK: - Properties
   
    private(set) weak var window: UIWindow!

    let tabBarWireframe: TabBarWireframe

    
    // MARK: - Public
    
    init(window: UIWindow) {
        self.window = window
        
        let walletWireframe = WalletWireframe(buyCoinWireframe: BuyCoinWireframe(), sellCoinWireframe: SellCoinWireframe())
        let transactionWireframe = TransactionsWireframe()
        self.tabBarWireframe = TabBarWireframe(walletWireframe, transactionWireframe)
    }
    
    func installRootViewController() {
        self.tabBarWireframe.installInto(window: self.window)
    }

}


