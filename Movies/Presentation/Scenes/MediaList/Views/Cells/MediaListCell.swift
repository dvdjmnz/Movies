//
//  ListItemCell.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import UIKit
import SnapKit

class MediaListCell: ResizableCollectionViewCell {
    enum Constants {
        static let cornerRadius: CGFloat = 8
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.addShadow()
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var ratingBlurredBackgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = Constants.cornerRadius
        visualEffectView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        visualEffectView.clipsToBounds = true
        return visualEffectView
    }()
    
    private lazy var bottomBlurredBackgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = Constants.cornerRadius
        visualEffectView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        visualEffectView.clipsToBounds = true
        visualEffectView.alpha = 0.8
        return visualEffectView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .headline1
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = .headline2
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var extraInfo1Label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .caption1
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var extraInfo2Label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .caption1
        label.textColor = .white
        label.textAlignment = .left
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
    
    func configure<Item: MediaItem>(item: Item) {
        ratingLabel.text = String(item.voteAverage)
        titleLabel.text = item.title
        backgroundImageView.setImage(url: item.posterPath, hasLoading: true)
    }
    
    func configure<Details: MediaItemDetails>(details: Details?) {
        if let details {
            extraInfo1Label.text = details.primaryInfo
            extraInfo2Label.text = details.secondaryInfo
        } else {
            extraInfo1Label.text = "-"
            extraInfo2Label.text = "-"
        }
    }
}

// MARK: Private Methods
private extension MediaListCell {
    private func setupUI() {
        backgroundColor = .clear
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(ratingBlurredBackgroundView)
        containerView.addSubview(bottomBlurredBackgroundView)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(extraInfo1Label)
        containerView.addSubview(extraInfo2Label)
        contentView.addSubview(containerView)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ratingBlurredBackgroundView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        
        bottomBlurredBackgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.top).offset(-8)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.leading.equalTo(ratingBlurredBackgroundView).offset(4)
            $0.bottom.trailing.equalTo(ratingBlurredBackgroundView).offset(-4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(bottomBlurredBackgroundView).offset(8)
            $0.trailing.equalTo(bottomBlurredBackgroundView).offset(-8)
        }
        
        extraInfo1Label.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(bottomBlurredBackgroundView).offset(8)
            $0.trailing.equalTo(bottomBlurredBackgroundView).offset(-8)
        }
        
        extraInfo2Label.snp.makeConstraints {
            $0.top.equalTo(extraInfo1Label.snp.bottom).offset(4)
            $0.leading.equalTo(bottomBlurredBackgroundView).offset(8)
            $0.bottom.trailing.equalTo(bottomBlurredBackgroundView).offset(-8)
        }
    }
}
