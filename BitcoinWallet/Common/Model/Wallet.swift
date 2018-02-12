//
//  Wallet.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation

struct Wallet {
    let currency: Currency
    private(set) var amount: Double
    
    mutating func setAmount(value: Double) {
        self.amount = value
    }
}

extension Wallet {
    
    var amountFormatted: String {
        if currency == .real {
            return "\(currency.symbol) \(realFormat(amount))"
        }
        // coins
        return "\(currency.symbol) \(amount)"
    }
    
    private func realFormat(_ amount: Double) -> String {
        return String(format: "%.02f", amount)
    }
}

extension Wallet: Hashable {
    static func ==(lhs: Wallet, rhs: Wallet) -> Bool {
        return lhs.currency.abbreviation.lowercased() == rhs.currency.abbreviation.lowercased()
    }
    
    var hashValue: Int {
        return currency.abbreviation.lowercased().hashValue
    }
}
