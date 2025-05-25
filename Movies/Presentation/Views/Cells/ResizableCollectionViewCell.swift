//
//  ResizableCollectionViewCell.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import UIKit 

class ResizableCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestureRecognizers() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didTapLongPressGesture))
        longPressGesture.minimumPressDuration = 0.00
        longPressGesture.delegate = self
        addGestureRecognizer(longPressGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapGesture))
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            animateCell(isPressed: true)
        case .ended, .cancelled, .changed:
            animateCell(isPressed: false)
        default:
            break
        }
    }
    
    @objc private func didTapGesture(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            if let collectionView = self.superview as? UICollectionView,
               let indexPath = collectionView.indexPath(for: self) {
                collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
            }
        }
    }
    
    private func animateCell(isPressed: Bool) {
        UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
            self.transform = isPressed ? CGAffineTransform(scaleX: 0.96, y: 0.96) : CGAffineTransform.identity
        }, completion: nil)
    }
}
    
// MARK: - UIGestureRecognizerDelegate
extension ResizableCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
}
