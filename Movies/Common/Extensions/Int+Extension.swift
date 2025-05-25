//
//  Int+Extension.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import Foundation

extension Int {
    func toUSDCurrencyCompact() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        if self >= 1_000_000_000 {
            let billions = Double(self) / 1_000_000_000
            return "$\(String(format: "%.1f", billions).replacingOccurrences(of: ".0", with: ""))B"
        } else if self >= 1_000_000 {
            let millions = Double(self) / 1_000_000
            return "$\(String(format: "%.1f", millions).replacingOccurrences(of: ".0", with: ""))M"
        } else if self >= 1_000 {
            let thousands = Double(self) / 1_000
            return "$\(String(format: "%.1f", thousands).replacingOccurrences(of: ".0", with: ""))K"
        } else {
            return "$\(self)"
        }
    }
}
