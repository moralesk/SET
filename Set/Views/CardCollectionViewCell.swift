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
                setColor()
                addDescriptionView()
            }
        }
    }

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
            case .red: backgroundColor = .red
            case .black: backgroundColor = .black
            case .blue: backgroundColor = .blue
            default: backgroundColor = .purple
            }
        }
    }

    // TODO: Update with assets
    private func addDescriptionView() {
        guard let card = card else {
            return
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
        shapeLabel.numberOfLines = 1
        shapeLabel.lineBreakMode = .byTruncatingMiddle
        if shapeLabel.superview == nil {
            self.contentView.addSubview(shapeLabel)
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
            self.contentView.addSubview(fillLabel)
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
            self.contentView.addSubview(countLabel)
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
