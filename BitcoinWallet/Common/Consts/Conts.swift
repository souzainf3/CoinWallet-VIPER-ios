//
//  Conts.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 05/02/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import UIKit

let myAppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

struct App {
    
    /// Versão vigente da aplicação.
    static let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    static let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""

    static let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    
    
    // MARK: - Currency
    
    struct Currency {
        static let decimalSeparator = NSLocale.current.decimalSeparator ?? ","
    }
    
   
    // MARK: - Keys

    struct Keys {
    }
    
    
    // MARK: - Colors
    
    struct Color {
    }

}


