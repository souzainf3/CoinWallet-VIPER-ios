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
    
    
    // MARK: - Date

    func testDateFormat() {
        
        // "date is 2015-05-07 18:48:08 +0000"
        let date =  Date(timeIntervalSince1970: 1431024488)
        
        XCTAssert(date.toString(format: "dd-MM-yyyy HH:mm:ssZZZ") == "07-05-2015 15:48:08-0300")
        XCTAssert(date.toString(format: "hh:mm") == "03:48")
        XCTAssert(date.toString(format: "HH:mm") == "15:48")
        XCTAssert(date.toString(format: "yyyy") == "2015")
    }
    
    
    // MARK: - Double
    
    func testDoubleStringConversion() {
        let num: Double = 0.000035
        XCTAssertEqual(num.toString(), "0.000035")
        
        let num2: Double = -0.000035
        XCTAssertEqual(num2.toString(), "-0.000035")

    }

}
