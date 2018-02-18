//
//  Conts.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 05/02/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import UIKit

typealias BlockCompletion = ()->Void

struct App {
    
    let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate


    // MARK: - Currency
    
    struct Config {
        static let standardCurrency: Currency = .real
        static let decimalSeparator = NSLocale.current.decimalSeparator ?? ","
    }
    
   
    // MARK: - Keys

    struct Keys {
        static let injectedMock = "bitcoinWallet.mock.injected"
    }
    
    
    // MARK: - Colors
    
    struct Color {
        static let textColor: UIColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
    }

}

extension Notification.Name {
    static let didChangeExchangeRate = Notification.Name("app.manager.notification.didChangeExchangeRate")
}


