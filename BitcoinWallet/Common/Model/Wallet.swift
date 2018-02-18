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
    
    mutating func increment(value: Double) {
        self.amount += value
    }
    
    mutating func decrement(value: Double) {
        self.amount -= value
    }
}

extension Wallet {
    var amountFormatted: String {
        return currency.formattedValue(amount)
    }
}

extension Wallet: Hashable {
    static func ==(lhs: Wallet, rhs: Wallet) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var hashValue: Int {
        return currency.abbreviation.lowercased().hashValue
    }
}
