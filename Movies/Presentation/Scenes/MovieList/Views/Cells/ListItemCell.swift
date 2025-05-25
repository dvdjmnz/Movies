//
//  ListItemCell.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import UIKit
import SnapKit

class ListItemCell: ResizableCollectionViewCell {
    enum Constants {
        static let cornerRadius: CGFloat = 8
    }
    
    var movie: Movie?
    
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
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var extraInfo1Label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var extraInfo2Label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
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
    
    func configure(movie: Movie) {
        self.movie = movie
        ratingLabel.text = String(movie.voteAverage)
        titleLabel.text = movie.title
        backgroundImageView.setImage(url: movie.posterPath, hasLoading: true)
    }
    
    func configure(movieDetails: MovieDetails?) {
        if let movieDetails {
            extraInfo1Label.text = movieDetails.budget
            extraInfo2Label.text = movieDetails.revenue
        } else {
            extraInfo1Label.text = "-"
            extraInfo2Label.text = "-"
        }
    }
}

// MARK: Private Methods
private extension ListItemCell {
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
