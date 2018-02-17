//
//  ExchangeRate.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 12/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation

// TODO: - Remover
//typealias RateValue = (currency: Currency, value: Double)

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

struct ExchangeRate {
    let currency: Currency
    var date: Date
    var rates: Set<Rate> = []
    
    mutating func update(date: Date) {
        self.date = date
    }
    
    mutating func setRate(_ newValue: Rate) {
        rates.update(with: newValue)
    }
}

extension ExchangeRate {
    func rate(from currency: Currency) -> Double? {
        return rates.first(where: { $0.currency == currency })?.value
    }
}

extension ExchangeRate: Hashable {
    static func ==(lhs: ExchangeRate, rhs: ExchangeRate) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var hashValue: Int {
        return self.currency.hashValue
    }
}

