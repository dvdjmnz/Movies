//
//  SelfSizedCollectionView.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import UIKit

final class SelfSizedCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
