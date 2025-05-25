//
//  GenreButton.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import UIKit

class GenreButton: UIButton {
    let genre: Genre
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateHighlightedState()
        }
    }
    
    init(genre: Genre) {
        self.genre = genre
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelected(_ selected: Bool) {
        isSelected = selected
    }
}

// MARK: - Private Methods
extension GenreButton {
    private func setupButton() {
        setTitle(genre.name, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        layer.cornerRadius = 20
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        updateAppearance()
    }
    
    private func updateAppearance() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            if self.isSelected {
                self.backgroundColor = .systemPurple
                self.setTitleColor(.white, for: .normal)
                self.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
                self.layer.shadowOpacity = 0.2
                self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            } else {
                self.backgroundColor = .systemGray6
                self.setTitleColor(.label, for: .normal)
                self.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
                self.layer.shadowOpacity = 0.1
                self.transform = .identity
            }
        })
    }
    
    private func updateHighlightedState() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: {
            if self.isHighlighted {
                self.alpha = 0.7
                self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.0, y: 1.0) : CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                self.alpha = 1.0
                self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.05, y: 1.05) : .identity
            }
        })
    }
}
