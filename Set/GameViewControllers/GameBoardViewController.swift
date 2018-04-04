//
//  GameBoardViewController.swift
//  Set
//
//  Created by Kelly Morales on 3/25/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

/// Where the game is played. Initialized with a number of players to determine if and how many buttons are added around the gameboard.
class GameBoardViewController: UIViewController {

    private var numberOfPlayers: Int?
    private var playerButtons: [PlayerButton] = []

    // MARK: Lifecycle Methods
    init(numberOfPlayers: Int) {
        super.init(nibName: nil, bundle: nil)
        self.numberOfPlayers = numberOfPlayers
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPlayerButtons()
    }

    private func setupPlayerButtons() {
        guard let numberOfPlayers = numberOfPlayers else {
            return
        }
        if numberOfPlayers > 1 {
            for i in 1...numberOfPlayers {
                let button = drawButtonForPlayer(num: i)
                playerButtons.append(button)
            }
        }
    }

    private func drawButtonForPlayer(num: Int) -> PlayerButton {
        let button = PlayerButton(color: getColorForPlayer(num))
        self.view.addSubview(button)
        setConstraintsForPlayerButton(button: button, number: num)
        return button
    }

    private func setConstraintsForPlayerButton(button: PlayerButton, number: Int) {
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
