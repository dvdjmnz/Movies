//
//  UIImageView+Extension.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Kingfisher

extension UIImageView {
    func setImage(url: URL?, hasLoading: Bool = false, loadingColor: UIColor? = nil) {
        kf.indicatorType = hasLoading ? .activity : .none
        if let loadingColor {
            (kf.indicator?.view as? UIActivityIndicatorView)?.color = loadingColor
        }
        kf.setImage(with: url, options: [.transition(.fade(0.2))])
    }
}
