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

    // MARK: Lifecycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initialize() {
        backgroundColor = .purple
        layer.cornerRadius = 3.0
    }

}
