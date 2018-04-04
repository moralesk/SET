//
//  PlayerButton.swift
//  Set
//
//  Created by Kelly Morales on 3/25/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

/// Button placed around the gameboard used for the players to select their SETs.
class PlayerButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
        layer.cornerRadius = 3.0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        setTitleColor(.white, for: .normal)
        setTitle("SCORE:", for: .normal)
        setTitle("SELECTING", for: .selected)
    }

    /// All player buttons will have the same height. Other constraints should be defined with the gameboard.
    func addHeightConstraint() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: superview, attribute: .height, multiplier: 0.08, constant: 0).isActive = true
    }

    func updateScore(score: Int) {
        setTitle("SCORE: \(score)", for: .normal)
    }
}
