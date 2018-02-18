//
//  Currency.swift
//  BitcoinWalletTests
//
//  Created by Romilson Nunes on 18/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import XCTest
@testable import BitcoinWallet

class CurrencyTests: XCTestCase {
    
    func testCurrencyAmountFormatation() {
        let amount = 10.353536
        let real: Currency = .real
        XCTAssertEqual(real.formattedValue(amount), "\(real.symbol) 10.35".localizedDecimalSeparator)
       
        let bitcoin: Currency = .bitcoin
        XCTAssertEqual(bitcoin.formattedValue(amount), "\(bitcoin.symbol) 10.353536".localizedDecimalSeparator)

        let britta: Currency = .britta
        XCTAssertEqual(britta.formattedValue(amount), "\(britta.symbol) 10.353536".localizedDecimalSeparator)
    }
    
}
