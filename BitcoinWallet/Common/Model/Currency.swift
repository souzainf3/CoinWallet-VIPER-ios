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
        case .britta:  return "฿T"
        }
    }
    
    var isVirtual: Bool {
        return self != .real
    }
    
    var color: UIColor {
        switch self {
        case .real:     return UIColor(red: 50/255, green: 146/255, blue: 57/255, alpha: 1)
        case .bitcoin:  return UIColor(red: 1, green: 0.75, blue: 0, alpha: 1)
        case .britta:   return .black
        }
    }
}

