//
//  ExchangeRate.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 12/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation

struct ExchangeRate {
    let currency: Currency
    let date: Date
    let rates: [(currency: Currency, value: Double)]
}

extension ExchangeRate {
    func rate(from currency: Currency) -> Double? {
        return rates.first(where: { $0.currency == currency })?.value
    }
}
