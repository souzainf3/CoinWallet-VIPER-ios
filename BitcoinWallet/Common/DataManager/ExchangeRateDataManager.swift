//
//  ExchangeRateDataManager.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 12/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation


enum ExchangeRateError: Error {
    case missingRate
    case unsupportedNegativeValue
}

protocol ExchangeRateDataManagerInput: class {
    var baseExchangeRate: ExchangeRate { get }

    func rate(from sourceCurrency: Currency, to targetCurrency: Currency) -> Double?
    func convert(amount: Double, from sourceCurrency: Currency, to targetCurrency: Currency) throws -> Double
    func update()
}

extension ExchangeRateDataManagerInput {
    /**
     *Convert an amount of currency to another currency*
     
     - parameter amount: amount to converter
     - parameter sourceCurrency: currency from value(amount)
     - parameter targetCurrency: cutput currency
     
     - returns: Value converted (Double)
     */
    func convert(amount: Double, from sourceCurrency: Currency, to targetCurrency: Currency) throws -> Double {
        
        guard amount >= 0 else {
            throw ExchangeRateError.unsupportedNegativeValue
        }
        
        guard let rate = self.rate(from: sourceCurrency, to: targetCurrency) else {
            throw ExchangeRateError.missingRate
        }
        
        return amount * rate
    }
    
    /**
     *Exchange rate of currency to another currency *
     
     - parameter sourceCurrency: source currency
     - parameter targetCurrency: cutput currency
     
     - returns: Value converted (Double)
     */
    func rate(from sourceCurrency: Currency, to targetCurrency: Currency) -> Double? {
        let baseCurrency = self.baseExchangeRate.currency
        
        // Base --> OtherCurrency
        if sourceCurrency == baseCurrency {
            return self.baseExchangeRate.rates.first(where: { $0.currency == targetCurrency })?.value
        }
        
        // OtherCurrency --> Base - inverse
        if targetCurrency == baseCurrency {
            guard let baseRate = rate(from: targetCurrency, to: sourceCurrency) else {
                return nil
            }
            return 1 / baseRate
        }
        
        // Between currencies different of the base
        guard let sourceBaseRate = rate(from: baseCurrency, to: sourceCurrency) else {
            return nil
        }
        guard let outputBaseRate = rate(from: baseCurrency, to: targetCurrency) else {
            return nil
        }
        return 1 / sourceBaseRate * outputBaseRate
    }
}


// MARK: - ExchangeRateDataManager

class ExchangeRateDataManager: ExchangeRateDataManagerInput {
    
    static let shared = ExchangeRateDataManager()
    
    private init() {
    }
    
    func update() {
        updateBrittaRate(completionHandler: { manager in
        })
    }
    
    let baseCurrency: Currency = .real
    
    private(set) var baseExchangeRate = ExchangeRate(
        currency: App.Config.standardCurrency,
        date: Date(),
        rates: []
    )

    func updateBrittaRate(completionHandler: @escaping (ExchangeRateDataManager)->Void) {
        FixerApi.getExchangeRates(from: baseCurrency.identifier, to: ["USD"]) { (result) in
            switch result {
            case .success(let rate):
                if let value: Double = rate.rates["USD"] {
                    self.baseExchangeRate.setRate(Rate(currency: .britta, value: value) )
                }
                completionHandler(self)
                
            case .failure:
                completionHandler(self)
            }
        }
    }
    
}


