//
//  HorizontalMenuView.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import UIKit
import RxSwift

final class HorizontalMenuView: UIView {
    let genreSelected = PublishSubject<Genre>()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return scrollView
    }()

    private lazy var scrollContainerView: UIView = {
        UIView()
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        return stackView
    }()

    init(_ genres: Genre...) {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        setupButtons(genres)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButtons(_ genres: [Genre]) {
        setupButtons(genres)
    }
}

// MARK: Private Methods
extension HorizontalMenuView {
    private func setupUI() {
        clipsToBounds = true
        scrollContainerView.addSubview(stackView)
        scrollView.addSubview(scrollContainerView)
        addSubview(scrollView)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(16)
            $0.bottom.equalTo(-32)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(88)
            $0.width.equalTo(stackView.snp.width)
            $0.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupButtons(_ genres: [Genre]) {
        stackView.removeAllArrangedSubviews()
        
        for (index, genre) in genres.enumerated() {
            let isFirst = index == 0
            let button = GenreButton(genre: genre)
            let action = UIAction { [weak self, genre] _ in
                self?.updateButtonSelection(selectedGenre: genre)
                self?.genreSelected.onNext(genre)
            }
            button.isSelected = isFirst
            button.addAction(action, for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    private func updateButtonSelection(selectedGenre: Genre) {
        for case let button as GenreButton in stackView.arrangedSubviews {
            button.isSelected = (button.genre == selectedGenre)
        }
    }
}
