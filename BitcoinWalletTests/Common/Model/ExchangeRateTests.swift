//
//  ExchangeRateTests.swift
//  BitcoinWalletTests
//
//  Created by Romilson Nunes on 13/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import XCTest
@testable import BitcoinWallet

class ExchangeRateTests: XCTestCase {
    
    func testExchangeRate() {
            
        let exchangeRate = ExchangeRate( currency: .real, date: Date(), rates: [Rate(currency: .bitcoin, value: 0.000035), Rate(currency: .britta, value: 0.3034)])

        XCTAssertNil(exchangeRate.rate(from: .real))

        XCTAssertNotNil(exchangeRate.rate(from: .bitcoin))
        XCTAssertEqual(exchangeRate.rate(from: .bitcoin), 0.000035)

        XCTAssertNotNil(exchangeRate.rate(from: .britta))
        XCTAssertEqual(exchangeRate.rate(from: .britta), 0.3034)
    }

}
