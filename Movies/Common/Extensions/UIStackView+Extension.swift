//
//  UIStackView+Extension.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        for view in arrangedSubviews {
            view.removeFromSuperview()
            removeArrangedSubview(view)
        }
    }
}
