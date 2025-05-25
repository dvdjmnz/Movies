//
//  ExtensionTests.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Movies

// MARK: - Extension Tests
class ExtensionTests: XCTestCase {
    func testDoubleToStringWithOneDecimal() {
        XCTAssertEqual(7.543.toStringWithOneDecimal(), "7.5")
        XCTAssertEqual(8.0.toStringWithOneDecimal(), "8.0")
        XCTAssertEqual(9.99.toStringWithOneDecimal(), "10.0")
    }
    
    func testIntToUSDCurrencyCompact() {
        XCTAssertEqual(500.toUSDCurrencyCompact(), "$500")
        XCTAssertEqual(1_500.toUSDCurrencyCompact(), "$1.5K")
        XCTAssertEqual(2_000_000.toUSDCurrencyCompact(), "$2M")
        XCTAssertEqual(1_500_000_000.toUSDCurrencyCompact(), "$1.5B")
    }
    
    func testStringToLocalizedDate() {
        let dateString = "2024-01-15"
        
        let result = dateString.toLocalizedDate()
        
        XCTAssertFalse(result.isEmpty)
        XCTAssertNotEqual(result, dateString)
    }
    
    func testStringToLocalizedDate_InvalidDate() {
        let invalidDate = "invalid-date"
        
        let result = invalidDate.toLocalizedDate()
        
        XCTAssertEqual(result, invalidDate)
    }
}
