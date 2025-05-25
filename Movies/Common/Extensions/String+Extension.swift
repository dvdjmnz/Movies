//
//  String+Extension.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import Foundation

extension String {
    func toLocalizedDate(dateFormat: String = "yyyy-MM-dd", style: DateFormatter.Style = .medium) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = dateFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = inputFormatter.date(from: self) else { return self }
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = style
        outputFormatter.locale = Locale.current
        return outputFormatter.string(from: date)
    }
}
