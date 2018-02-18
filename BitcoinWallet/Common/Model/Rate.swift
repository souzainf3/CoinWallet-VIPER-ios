//
//  Rate.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 17/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation

struct Rate {
    let currency: Currency
    let value: Double
}

extension Rate: Hashable {
    var hashValue: Int { return self.currency.hashValue }
    
    static func ==(lhs: Rate, rhs: Rate) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
