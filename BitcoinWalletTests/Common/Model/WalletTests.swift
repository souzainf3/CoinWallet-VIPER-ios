//
//  WalletTests.swift
//  BitcoinWalletTests
//
//  Created by Romilson Nunes on 13/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import XCTest
@testable import BitcoinWallet

class WalletTests: XCTestCase {
    
    func testWalletAmountUpdate() {
        var realWallet = Wallet(currency: .real, amount: 100.38)
        XCTAssertEqual(realWallet.amount, 100.38)

        realWallet.increment(value: 1)
        XCTAssertEqual(realWallet.amount, 101.38)

        realWallet.decrement(value: 2)
        XCTAssertEqual(realWallet.amount, 99.38)
    }

    func testWalletAmountFormat() {
        let realWallet = Wallet(currency: .real, amount: 100.3811)
        let bitcoinWallet = Wallet(currency: .bitcoin, amount: 0.0001)

        XCTAssertEqual(realWallet.amountFormatted, "R$ 100.38")
        XCTAssertEqual(bitcoinWallet.amountFormatted, "฿ 0.0001")
    }
    
    func testWalletEquatable() {
        let realWallet1 = Wallet(currency: .real, amount: 100)
        let realWallet2 = Wallet(currency: .real, amount: 0)
        let bitcoinWallet = Wallet(currency: .bitcoin, amount: 0.01)

        XCTAssertEqual(realWallet1, realWallet2)
        XCTAssert(bitcoinWallet != realWallet1)
        XCTAssert(bitcoinWallet != realWallet2)
    }
}
