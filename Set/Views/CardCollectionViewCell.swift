//
//  CardCollectionViewCell.swift
//  Set
//
//  Created by Kelly Morales on 4/4/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

/// Displays the Card cells in the gameboard collectionView.
class CardCollectionViewCell: UICollectionViewCell {

    var card: Card? {
        didSet {
            if card != nil {
                // TODO: remove when assets are available
                addDescriptionView()
                setColor()
            }
        }
    }

    /// Tracks whether the cell is part of the current SET being chosen
    var isChosen: Bool = false {
        didSet {
            isUserInteractionEnabled = !isChosen
            if isChosen {
                backgroundColor = .purple
            } else {
                backgroundColor = descriptionView?.backgroundColor
            }
        }
    }

    /// Container view for description labels when assets aren't found
    var descriptionView: UIView?

    // MARK: Lifecycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initialize() {
        layer.cornerRadius = 3.0
    }

    private func setColor() {
        if let card = card {
            switch card.color {
            case .red: descriptionView?.backgroundColor = .red
            case .black: descriptionView?.backgroundColor = .black
            case .blue: descriptionView?.backgroundColor = .blue
            default: descriptionView?.backgroundColor = .purple
            }
            backgroundColor = descriptionView?.backgroundColor
        }
    }

    // TODO: Update with assets
    /// Adds container view with labels while assets are unavailable
    private func addDescriptionView() {
        guard let card = card else {
            return
        }
        descriptionView = UIView()
        guard let descriptionView = descriptionView else {
            return
        }
        if descriptionView.superview == nil {
            self.contentView.addSubview(descriptionView)
            descriptionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: descriptionView, attribute: .top, relatedBy: .equal, toItem: descriptionView.superview, attribute: .top, multiplier: 1, constant: 2).isActive = true
            NSLayoutConstraint(item: descriptionView, attribute: .left, relatedBy: .equal, toItem: descriptionView.superview, attribute: .left, multiplier: 1, constant: 2).isActive = true
            NSLayoutConstraint(item: descriptionView, attribute: .right, relatedBy: .equal, toItem: descriptionView.superview, attribute: .right, multiplier: 1, constant: -2).isActive = true
            NSLayoutConstraint(item: descriptionView, attribute: .bottom, relatedBy: .equal, toItem: descriptionView.superview, attribute: .bottom, multiplier: 1, constant: -2).isActive = true
        }

        let shape = String.init(describing: card.shape)
        let fill = String.init(describing: card.fill)
        let count = String.init(describing: card.count)
        let labelFont = UIFont.systemFont(ofSize: 10.0, weight: .heavy)

        let shapeLabel = UILabel()
        shapeLabel.text = "Shape: \(shape)"
        shapeLabel.font = labelFont
        shapeLabel.textColor = .white
        shapeLabel.textAlignment = .center
        shapeLabel.numberOfLines = 0
        shapeLabel.lineBreakMode = .byWordWrapping
        if shapeLabel.superview == nil {
            descriptionView.addSubview(shapeLabel)
            shapeLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: shapeLabel, attribute: .top, relatedBy: .equal, toItem: shapeLabel.superview, attribute: .top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: shapeLabel, attribute: .width, relatedBy: .equal, toItem: shapeLabel.superview, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
            NSLayoutConstraint(item: shapeLabel, attribute: .centerX, relatedBy: .equal, toItem: shapeLabel.superview, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        }

        let fillLabel = UILabel()
        fillLabel.text = "Fill: \(fill)"
        fillLabel.font = labelFont
        fillLabel.textColor = .white
        fillLabel.textAlignment = .center
        fillLabel.numberOfLines = 1
        fillLabel.lineBreakMode = .byTruncatingMiddle
        if fillLabel.superview == nil {
            descriptionView.addSubview(fillLabel)
            fillLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: fillLabel, attribute: .centerY, relatedBy: .equal, toItem: fillLabel.superview, attribute: .bottom, multiplier: 0.5, constant: 0).isActive = true
            NSLayoutConstraint(item: fillLabel, attribute: .width, relatedBy: .equal, toItem: fillLabel.superview, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
            NSLayoutConstraint(item: fillLabel, attribute: .centerX, relatedBy: .equal, toItem: fillLabel.superview, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        }

        let countLabel = UILabel()
        countLabel.text = "Count: \(count)"
        countLabel.font = labelFont
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countLabel.numberOfLines = 1
        countLabel.lineBreakMode = .byTruncatingMiddle
        if countLabel.superview == nil {
            descriptionView.addSubview(countLabel)
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: countLabel, attribute: .width, relatedBy: .equal, toItem: countLabel.superview, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
            NSLayoutConstraint(item: countLabel, attribute: .centerX, relatedBy: .equal, toItem: countLabel.superview, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: countLabel, attribute: .bottom, relatedBy: .equal, toItem: countLabel.superview, attribute: .bottom, multiplier: 0.95, constant: 0).isActive = true
        }
    }

    static func reuseID() -> String {
        return "CardCell"
    }
}
