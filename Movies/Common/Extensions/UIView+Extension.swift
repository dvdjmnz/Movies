//
//  UIView+Extension.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import UIKit

extension UIView {
    func addShadow(offset: CGSize = CGSize(width: 0, height: 4), blur: CGFloat = 8, opacity: Float = 0.2) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = blur
        self.layer.shadowOpacity = opacity
    }
}
