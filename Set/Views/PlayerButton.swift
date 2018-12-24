//
//  PlayerButton.swift
//  Set
//
//  Created by Kelly Morales on 3/25/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

/// Functions that affect the game board when a player button is selected
protocol GameBoardButtonProtocol {
    func playerSelecting()
    func playerStoppedSelecting()
}

/// Button placed around the gameboard used for the players to select their SETs.
class PlayerButton: UIButton {

    var isSelecting: Bool = false
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                setToSelectedState()
            } else {
                perform(#selector(self.setToDefaultState), with: nil, afterDelay: 3)
            }
        }
    }

    var gameBoardButtonDelegate: GameBoardButtonProtocol?
    private var playerScore: Int = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
        layer.cornerRadius = 3.0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        setTitleColor(.white, for: UIControlState())
        setTitle("SCORE: \(playerScore)", for: .normal)
    }

    /// All player buttons will have the same height. Other constraints should be defined within the gameboard.
    func addHeightConstraint() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: superview, attribute: .height, multiplier: 0.08, constant: 0).isActive = true
    }

    func incrementScore() {
        playerScore += 1
    }

    func setState(selected: Bool) {
        if selected {
            setToSelectedState()
        } else {
            setToDefaultState()
        }
    }

    private func setToSelectedState() {
        setTitle("SELECTING...", for: .normal)
        backgroundColor = backgroundColor?.withAlphaComponent(0.8)
        isUserInteractionEnabled = false
        isSelecting = true
        gameBoardButtonDelegate?.playerSelecting()
    }

    @objc private func setToDefaultState() {
        setTitle("SCORE: \(playerScore)", for: .normal)
        backgroundColor = backgroundColor?.withAlphaComponent(1)
        isUserInteractionEnabled = true
        isSelecting = false
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        gameBoardButtonDelegate?.playerStoppedSelecting()
    }
}
