//
//  Double+Extension.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import Foundation

extension Double {
    func toStringWithOneDecimal() -> String {
        String(format: "%.1f", self)
    }
}
