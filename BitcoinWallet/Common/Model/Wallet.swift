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
