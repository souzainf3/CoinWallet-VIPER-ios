//
//  ExtensionsTests.swift
//  BitcoinWalletTests
//
//  Created by Romilson Nunes on 13/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import XCTest
@testable import BitcoinWallet

class ExtensionsTests: XCTestCase {
    
    // MARK: - String

    func testOccurrencesOfSubstring() {
        let string = "swift is cool"
        let swift = "swift"
        let java = "java"
        
        XCTAssertTrue(string.hasOccurrencesOf(swift))
        XCTAssertEqual(string.count(occurrencesOf: swift), 1)
        
        // Case sensitive
        XCTAssertFalse(string.hasOccurrencesOf(swift.uppercased()))
        XCTAssertEqual(string.count(occurrencesOf: swift.uppercased()), 0)

        // Nonexistent
        XCTAssertFalse(string.hasOccurrencesOf(java))
        XCTAssertEqual(string.count(occurrencesOf: java), 0)
    }
    
    // Diacritic Insensitive
    func testOccurrencesOfSubstringDiacriticInsensitive() {
        let string = "‘ö’ is equal ‘o’"
        let findString = "ö"

        XCTAssertTrue(string.hasOccurrencesOf(findString))
        XCTAssertEqual(string.count(occurrencesOf: findString), 2)
        
        // Case sensitive
        XCTAssertFalse(string.hasOccurrencesOf(findString.uppercased()))
        XCTAssertEqual(string.count(occurrencesOf: findString.uppercased()), 0)
    }
}
