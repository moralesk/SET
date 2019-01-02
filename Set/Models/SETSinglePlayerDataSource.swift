//
//  SETSinglePlayerDataSource.swift
//  Set
//
//  Created by Kelly Morales on 12/31/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import UIKit

/// Instance of SETGameBoardDataSourceProtocol for a single player set up
class SETSinglePlayerDataSource: SETGameBoardDataSourceProtocol {

    weak var gameBoardDelegate: SETGameBoardProtocol?
    private var singlePlayerScoreLabel: UILabel = UILabel()
    private var singlePlayerScore: Int = 0 {
        didSet {
            singlePlayerScoreLabel.text = "SCORE: \(singlePlayerScore)"
        }
    }

    // MARK:- SETGameBoardDataSourceProtocol
    func setupPlayerElements() {
        setupScoreLabel()
    }

    func completeGameBoardConstraints() {
        guard let gameBoard = gameBoardDelegate?.gameBoard else {
            return
        }
        NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: gameBoard.superview, attribute: NSLayoutAttribute.topMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: singlePlayerScoreLabel, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0).isActive = true
    }

    func processSet(valid: Bool) {
        if valid {
            singlePlayerScore += 1
        }
    }

    // MARK:- Helpers
    private func setupScoreLabel() {
        if singlePlayerScoreLabel.superview == nil {
            if let delegate = gameBoardDelegate as? UIViewController {
                delegate.view.addSubview(singlePlayerScoreLabel)
            }
        }
        singlePlayerScoreLabel.textAlignment = .center
        singlePlayerScoreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        singlePlayerScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        singlePlayerScoreLabel.text = "SCORE: \(singlePlayerScore)"
        NSLayoutConstraint(item: singlePlayerScoreLabel, attribute: .bottom, relatedBy: .equal, toItem: singlePlayerScoreLabel.superview, attribute: .bottomMargin, multiplier: 0.98, constant: 0).isActive = true
        NSLayoutConstraint(item: singlePlayerScoreLabel, attribute: .centerX, relatedBy: .equal, toItem: singlePlayerScoreLabel.superview, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: singlePlayerScoreLabel, attribute: .width, relatedBy: .equal, toItem: singlePlayerScoreLabel.superview, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: singlePlayerScoreLabel, attribute: .height, relatedBy: .equal, toItem: singlePlayerScoreLabel.superview, attribute: .height, multiplier: 0.1, constant: 0).isActive = true
    }
}
