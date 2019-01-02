//
//  SETMultiPlayerDataSource.swift
//  Set
//
//  Created by Kelly Morales on 12/31/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import UIKit

/// Instance of SETGameBoardDataSourceProtocol for a multi player set up
class SETMultiPlayerDataSource: SETGameBoardDataSourceProtocol {

    weak var gameBoardDelegate: SETGameBoardProtocol?
    private var numberOfPlayers: Int?
    private var playerButtons: [SETPlayerButton] = []

    /// Determines if the cards can be selected
    private var cardSelectionEnabled: Bool = false {
        didSet{
            gameBoardDelegate?.gameBoard?.isUserInteractionEnabled = cardSelectionEnabled
        }
    }

    init(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
    }

    // MARK:- SETGameBoardDataSourceProtocol
    func setupPlayerElements() {
        setupPlayerButtons()
    }

    func completeGameBoardConstraints() {
        let bottomPlayerButton = playerButtons[0]
        let topPlayerButton = playerButtons[1]
        guard let gameBoard = gameBoardDelegate?.gameBoard else {
            return
        }
        NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topPlayerButton, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: bottomPlayerButton, attribute: NSLayoutAttribute.topMargin, multiplier: 1, constant: -10).isActive = true

        gameBoard.isUserInteractionEnabled = false
    }

    func processSet(valid: Bool) {
        for button in playerButtons {
            if button.isSelecting {
                if valid {
                    button.incrementScore()
                }
                button.setState(selected: false)
            }
        }
    }

    // MARK:- Helpers
    private func setupPlayerButtons() {
        guard let numberOfPlayers = numberOfPlayers else {
            return
        }
        for i in 1...numberOfPlayers {
            let button = drawButtonForPlayer(num: i)
            button.playerButtonDelegate = self
            playerButtons.append(button)
        }
    }

    /// Adds the color and constraints for a player's button
    private func drawButtonForPlayer(num: Int) -> SETPlayerButton {
        let button = SETPlayerButton(color: getColorForPlayer(num))
        if let delegate = gameBoardDelegate as? UIViewController {
            delegate.view.addSubview(button)
        }
        setConstraintsForPlayerButton(button: button, number: num)
        return button
    }

    /// Sets the location and adds constraints for a player button depending on the player number
    private func setConstraintsForPlayerButton(button: SETPlayerButton, number: Int) {
        guard let numberOfPlayers = numberOfPlayers else {
            return
        }
        switch number {
        case 1:
            NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: button.superview, attribute: .bottomMargin, multiplier: 0.98, constant: 0).isActive = true
            if numberOfPlayers > 2 {
                NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: button.superview, attribute: .leftMargin, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: button.superview, attribute: .centerX, multiplier: 0.95, constant: 0).isActive = true
            } else {
                NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: button.superview, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: button.superview, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
            }
        case 2:
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: button.superview, attribute: .topMargin, multiplier: 1.2, constant: 0).isActive = true
            if numberOfPlayers > 3 {
                NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: button.superview, attribute: .leftMargin, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: button.superview, attribute: .centerX, multiplier: 0.95, constant: 0).isActive = true
            } else {
                NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: button.superview, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: button.superview, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
            }
            button.transform = button.transform.rotated(by: .pi)
        case 3:
            NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: button.superview, attribute: .bottomMargin, multiplier: 0.98, constant: 0).isActive = true
            NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: button.superview, attribute: .centerX, multiplier: 0.98, constant: 0).isActive = true
            NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: button.superview, attribute: .rightMargin, multiplier: 1, constant: 0).isActive = true
        case 4:
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: button.superview, attribute: .topMargin, multiplier: 1.2, constant: 0).isActive = true
            NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: button.superview, attribute: .centerX, multiplier: 0.98, constant: 0).isActive = true
            NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: button.superview, attribute: .rightMargin, multiplier: 1, constant: 0).isActive = true
            button.transform = button.transform.rotated(by: .pi)
        default:
            return
        }
        button.addHeightConstraint()
    }

    /// Returns a UIColor based on the player number
    private func getColorForPlayer(_ num: Int) -> UIColor {
        switch num {
        case 1: return .blue
        case 2: return .purple
        case 3: return .black
        case 4: return .red
        default: return .blue
        }
    }
}

// MARK:- GameBoardButtonProtocol
extension SETMultiPlayerDataSource: SETPlayerButtonProtocol {
    /**
     When a player button is pressed: disable all player buttons, enable card selection, and disable the exit button.
     */
    func playerSelecting() {
        for button in playerButtons {
            button.isUserInteractionEnabled = false
        }
        cardSelectionEnabled = true
        if let delegate = gameBoardDelegate as? UIViewController {
            delegate.navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }

    /**
     When a player's turn is over: enable all player buttons, unselect cards and disable card selection, enable the exit button.
     */
    func playerStoppedSelecting() {
        for button in playerButtons {
            button.isUserInteractionEnabled = true
        }
        cardSelectionEnabled = false
        if let delegate = gameBoardDelegate as? UIViewController {
            delegate.navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
}
