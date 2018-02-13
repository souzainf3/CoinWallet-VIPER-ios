//
//  ExchangeRateDataManager.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 12/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation


enum ExchangeRateError: Error {
    case missingCurrency
    case missingRate
    case unsupportedNegativeValue

}

protocol ExchangeRateDataManagerInput: class {
    var rates: [ExchangeRate] { get set }
    func converter(amount: Double, from sourceCurrency: Currency, to targetCurrency: Currency) throws -> Double
    func exchangeRate(from currency: Currency) -> ExchangeRate?
}

extension ExchangeRateDataManagerInput {
    /**
     *Converter an amount of currency to another currency*
     
     - parameter amount: amount to converter
     - parameter sourceCurrency: currency from value(amount)
     - parameter targetCurrency: cutput currency
     
     - returns: Value converted (Double)
     */
    func converter(amount: Double, from sourceCurrency: Currency, to targetCurrency: Currency) throws -> Double {
        
        guard amount >= 0 else {
            throw ExchangeRateError.unsupportedNegativeValue
        }
        
        guard let exchangeRate = self.exchangeRate(from: sourceCurrency) else {
            throw ExchangeRateError.missingCurrency
        }
        
        guard let rate = exchangeRate.rate(from: targetCurrency) else {
            throw ExchangeRateError.missingRate
        }
        
        return amount * rate
    }
    
    /**
     *Serch exchange rate from a currency in rate list. *
     
     - parameter currency: currency to found
     
     - returns: ExchangeRate from the currency
     */
    func exchangeRate(from currency: Currency) -> ExchangeRate? {
        return rates.first(where: { $0.currency == currency })
    }
}


// MARK: - ExchangeRateDataManager

class ExchangeRateDataManager: ExchangeRateDataManagerInput {
    
    // TODO: - Remover Mock
    var rates: [ExchangeRate] = [
        ExchangeRate(
            currency: .real,
            rates: [
                (currency: .bitcoin, value: 0.000035),
                (currency: .britta, value: 0.3034)
            ]
        ),
        ExchangeRate(
            currency: .bitcoin,
            rates: [
                (currency: .real, value: 28600.0),
                (currency: .britta, value: 8690.4)
            ]
        ),
        ExchangeRate(
            currency: .britta,
            rates: [
                (currency: .real, value: 3.2954),
                (currency: .bitcoin, value: 0.000115)
            ]
        )
    ]
    
}

