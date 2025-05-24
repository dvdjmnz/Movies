//
//  ListItemCell.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import UIKit
import SnapKit

class ListItemCell: ResizableCollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow()
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var blurredBackgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = 8
        visualEffectView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        visualEffectView.clipsToBounds = true
        visualEffectView.alpha = 0.7
        return visualEffectView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure() {
        titleLabel.text = "Title"
        ratingLabel.text = "Rating"
        let url = [
            URL(string: "https://image.tmdb.org/t/p/w500/tUae3mefrDVTgm5mRzqWnZK6fOP.jpg"),
            URL(string: "https://image.tmdb.org/t/p/w500/wTnV3PCVW5O92JMrFvvrRcV39RU.jpg"),
            URL(string: "https://image.tmdb.org/t/p/w500/wkK7w1XufrVL7qd4UzKyv0X6Gur.jpg"),
            URL(string: "https://image.tmdb.org/t/p/w500/6WxhEvFsauuACfv8HyoVX6mZKFj.jpg"),
            URL(string: "https://image.tmdb.org/t/p/w500/vWNVHtwOhcoOEUSrY1iHRGbgH8O.jpg"),
            URL(string: "https://image.tmdb.org/t/p/w500/bBJGmU0ORhmo0liy7c3MdI8qOMU.jpg")
        ].randomElement()!
        backgroundImageView.setImage(url: url, hasLoading: true)
    }
}

// MARK: Private Methods
private extension ListItemCell {
    private func setupUI() {
        backgroundColor = .clear
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(blurredBackgroundView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(ratingLabel)
        contentView.addSubview(containerView)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        blurredBackgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.top).offset(-8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(ratingLabel.snp.top).offset(-8)
            $0.leading.equalTo(8)
        }

        ratingLabel.snp.makeConstraints {
            $0.bottom.equalTo(-8)
            $0.leading.equalTo(8)
        }
    }
}
