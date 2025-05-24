//
//  UICollectionView+Extension.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import UIKit

extension UICollectionView {
    func register(_ cellClasses: UICollectionViewCell.Type...) {
        for cellClass in cellClasses {
            register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }
    }

    func dequeue<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }
}
