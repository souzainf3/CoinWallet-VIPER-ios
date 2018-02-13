//
//  WalletDataManagerTests.swift
//  BitcoinWalletTests
//
//  Created by Romilson Nunes on 13/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import XCTest
@testable import BitcoinWallet

class WalletDataManagerTests: XCTestCase {
    
    let walletManagerMock = WalletDataManager(database: DatabaseManager(configuration: .inMemory(identifier: "tests.wallet")))
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Testar quantidade de carteiras e valores iniciais
    func testUserWallets() {
        let wallets = walletManagerMock.fetchUserWallets()
        XCTAssertEqual(wallets.count, Currency.all.count)
        
        wallets.forEach { item in
            XCTAssertEqual(item.amount , 0.0)
        }
    }
    
    func testUserWalletFromCurrency() {
        XCTAssertEqual(walletManagerMock.fetchUserWallet(from: .real).amount , 0.0)
        XCTAssertEqual(walletManagerMock.fetchUserWallet(from: .bitcoin).amount, 0.0)
        XCTAssertEqual(walletManagerMock.fetchUserWallet(from: .britta).amount, 0.0)
    }
    
    func testIncrementWallet() {
        // real
        walletManagerMock.incrementWallet(amount: 100, currency: .real)
        walletManagerMock.increment(amount: 10, to: walletManagerMock.fetchUserWallet(from: .real))
        // bitcoin
        walletManagerMock.incrementWallet(amount: 0.1, currency: .bitcoin)
        walletManagerMock.increment(amount: 1, to: walletManagerMock.fetchUserWallet(from: .bitcoin))
        // britta
        walletManagerMock.incrementWallet(amount: 50, currency: .britta)
        walletManagerMock.increment(amount: 50.1, to: walletManagerMock.fetchUserWallet(from: .britta))
        
        XCTAssertEqual(walletManagerMock.fetchUserWallet(from: .real).amount, 110)
        XCTAssertEqual(walletManagerMock.fetchUserWallet(from: .bitcoin).amount, 1.1)
        XCTAssertEqual(walletManagerMock.fetchUserWallet(from: .britta).amount, 100.1)
    }

    func testDecrementWallet() {
        // Default
        walletManagerMock.incrementWallet(amount: 1000, currency: .real)
        walletManagerMock.incrementWallet(amount: 1000, currency: .bitcoin)
        walletManagerMock.incrementWallet(amount: 1000, currency: .britta)

        // real
        walletManagerMock.decrementWallet(amount: 100, currency: .real)
        walletManagerMock.decrement(amount: 10, from: walletManagerMock.fetchUserWallet(from: .real))
        // bitcoin
        walletManagerMock.decrementWallet(amount: 0.1, currency: .bitcoin)
        walletManagerMock.decrement(amount: 1, from: walletManagerMock.fetchUserWallet(from: .bitcoin))
        // britta
        walletManagerMock.decrementWallet(amount: 50, currency: .britta)
        walletManagerMock.decrement(amount: 50.1, from: walletManagerMock.fetchUserWallet(from: .britta))
        
        XCTAssertEqual(walletManagerMock.fetchUserWallet(from: .real).amount, 890)
        XCTAssertEqual(walletManagerMock.fetchUserWallet(from: .bitcoin).amount, 998.9)
        XCTAssertEqual(walletManagerMock.fetchUserWallet(from: .britta).amount, 899.9)
    }
}
