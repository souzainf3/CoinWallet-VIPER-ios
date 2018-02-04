//
//  Coin.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

enum Currency: String {
    case real
    case bitcoin
    case britta
    
    static let all: [Currency] = [.real, .bitcoin, .britta]
    
    var name: String {
        return self.rawValue
    }
    
    var abbreviation: String {
        switch self {
        case .real:     return "BRL"
        case .bitcoin:  return "BTC"
        case .britta:   return "BRT"
        }
    }
    
    var symbol: String {
        switch self {
        case .real:    return "R$"
        case .bitcoin: return "฿"
        case .britta:  return "B$"
        }
    }
    
    var isVirtual: Bool {
        return self != .real
    }
    
    var color: UIColor {
        switch self {
        // #329239    (50,146,57)
        case .real:     return UIColor(red: 50/255, green: 146/255, blue: 57/255, alpha: 1)
        // #f7931a    (247,147,26)
        case .bitcoin:  return UIColor(red: 247/255, green: 147/255, blue: 26/255, alpha: 1)
        // #0d579b    (13,87,155)
        case .britta:   return UIColor(red: 13/255, green: 87/255, blue: 155/255, alpha: 1)
        }
    }
}

