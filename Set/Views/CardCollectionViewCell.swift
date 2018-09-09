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

    static func reuseID() -> String {
        return "CardCell"
    }
}
