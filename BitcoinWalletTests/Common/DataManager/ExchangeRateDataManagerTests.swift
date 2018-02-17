//
//  ExchangeRateDataManagerTests.swift
//  BitcoinWalletTests
//
//  Created by Romilson Nunes on 13/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import XCTest
@testable import BitcoinWallet

// MARK: - Mock

class ExchangeRateDataManagerMock: ExchangeRateDataManagerInput {
    var rates: Set<ExchangeRate> = []
    
    func update() {
    }
    
    var baseExchangeRate = ExchangeRate(
        currency: .real,
        date: Date(),
        rates: [
            Rate(currency: .britta, value: 0.5),
            Rate(currency: .bitcoin, value: 0.01)
        ]
    )
    

//    var rates: [ExchangeRate] = [
//        ExchangeRate(
//            currency: .real,
//            date: Date(),
//            rates: [
//                (currency: .bitcoin, value: 0.01),
//                (currency: .britta, value: 0.5)
//            ]
//        ),
//        ExchangeRate(
//            currency: .bitcoin,
//            date: Date(),
//            rates: [
//                (currency: .real, value: 100),
//                (currency: .britta, value: 50)
//            ]
//        ),
//        ExchangeRate(
//            currency: .britta,
//            date: Date(),
//            rates: [
//                (currency: .real, value: 2),
//                (currency: .bitcoin, value: 0.02)
//            ]
//        )
//    ]
}

class ExchangeRateDataManagerMissingMock: ExchangeRateDataManagerInput {
    var rates: Set<ExchangeRate> = []
    
    func update() {
        
    }
    
    var baseExchangeRate = ExchangeRate(
        currency: .real,
        date: Date(),
        rates: [
            Rate(currency: .bitcoin, value: 0.1),
        ]
    )
    
//    var rates: [ExchangeRate] = [
//        ExchangeRate(
//            currency: .real,
//            date: Date(),
//            rates: [
//                (currency: .bitcoin, value: 0.01),
//            ]
//        )
//    ]
}


class ExchangeRateDataManagerTests: XCTestCase {
    
    let mock = ExchangeRateDataManagerMock()
    let misssingMock = ExchangeRateDataManagerMissingMock()
    
    func testExchangeNegativeValue() {
        XCTAssertThrowsError(try misssingMock.convert(amount: -100, from: .real, to: .britta), "Missing") { error in
            XCTAssertTrue(error is ExchangeRateError)
            XCTAssertEqual(error as! ExchangeRateError, ExchangeRateError.unsupportedNegativeValue)
        }
    }

    func testExchangeMissingRate() {
        XCTAssertThrowsError(try misssingMock.convert(amount: 10, from: .real, to: .britta), "Missing") { error in
            XCTAssertTrue(error is ExchangeRateError)
            XCTAssertEqual(error as! ExchangeRateError, ExchangeRateError.missingRate)
        }
    }
    
    func testExchangeRateConverter() {
        // bitcoin to real
        do {
            XCTAssertEqual(try mock.convert(amount: 0.0, from: .bitcoin, to: .real), 0)
            XCTAssertEqual(try mock.convert(amount: 0.5, from: .bitcoin, to: .real), 50)
            XCTAssertEqual(try mock.convert(amount: 1.0, from: .bitcoin, to: .real), 100)
            XCTAssertEqual(try mock.convert(amount: 2.5, from: .bitcoin, to: .real), 250)
        }
        
        // real to bitcoin
        do {
            XCTAssertEqual(try mock.convert(amount: 0.0, from: .real, to: .bitcoin), 0)
            XCTAssertEqual(try mock.convert(amount: 1.0, from: .real, to: .bitcoin), 0.01)
            XCTAssertEqual(try mock.convert(amount: 2.5, from: .real, to: .bitcoin), 0.025)
            XCTAssertEqual(try mock.convert(amount: 100, from: .real, to: .bitcoin), 1)
        }
        
        do {
            // from real
            var amount = 100.0
            // to bitcoin
            amount = try mock.convert(amount: amount, from: .real, to: .bitcoin)
            XCTAssertEqual(amount, 1)
            // to britta
            amount = try mock.convert(amount: amount, from: .bitcoin, to: .britta)
            XCTAssertEqual(amount, 50)
            // to real
            amount = try mock.convert(amount: amount, from: .britta, to: .real)
            XCTAssertEqual(amount, 100)
            // to britta
            amount = try mock.convert(amount: amount, from: .real, to: .britta)
            XCTAssertEqual(amount, 50)
        } catch _ {}
    }
    
    func testExchangeRateSearch() {
    }
}
