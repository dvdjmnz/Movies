//
//  UICollectionViewCell+Extension.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import UIKit

extension UICollectionViewCell {
    class var reuseIdentifier: String {
        String(describing: self)
    }
}
