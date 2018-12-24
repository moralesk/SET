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
    private lazy var singlePlayerScoreLabel: UILabel = UILabel()

    private var gameBoard: UICollectionView?

    private var collectionViewCellWidth: CGFloat {
        get {
            return self.view.bounds.width * 0.22
        }
    }
    private var collectionViewCellHeight: CGFloat {
        get {
            return self.view.bounds.height * 0.13
        }
    }
    private var spaceBetweenCollectionViewCells: CGFloat {
        get {
            return self.view.bounds.width * 0.013
        }
    }
    private var spaceBetweenCollectionViewSections: CGFloat {
        get {
            return self.view.bounds.height * 0.02
        }
    }

    private var currentSet: [CardCollectionViewCell] = []

    /// Determines if the cards can be selected
    private var cardSelectionEnabled: Bool = false {
        didSet{
            gameBoard?.isUserInteractionEnabled = cardSelectionEnabled
            if !cardSelectionEnabled {
                currentSet.removeAll()
            }
        }
    }

    // MARK:- Lifecycle Methods
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
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "EXIT", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = backButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPlayerButtons()
        setupCollectionView()
    }

    private func setupPlayerButtons() {
        guard let numberOfPlayers = numberOfPlayers else {
            return
        }
        if numberOfPlayers > 1 {
            for i in 1...numberOfPlayers {
                let button = drawButtonForPlayer(num: i)
                button.gameBoardButtonDelegate = self
                playerButtons.append(button)
            }
        } else {
            setupScoreLabel()
        }
    }

    private func setupScoreLabel() {
        if singlePlayerScoreLabel.superview == nil {
            self.view.addSubview(singlePlayerScoreLabel)
        }
        singlePlayerScoreLabel.textAlignment = .center
        singlePlayerScoreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        singlePlayerScoreLabel.text = "SCORE:"
        singlePlayerScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: singlePlayerScoreLabel, attribute: .bottom, relatedBy: .equal, toItem: singlePlayerScoreLabel.superview, attribute: .bottomMargin, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: singlePlayerScoreLabel, attribute: .centerX, relatedBy: .equal, toItem: singlePlayerScoreLabel.superview, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: singlePlayerScoreLabel, attribute: .width, relatedBy: .equal, toItem: singlePlayerScoreLabel.superview, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: singlePlayerScoreLabel, attribute: .height, relatedBy: .equal, toItem: singlePlayerScoreLabel.superview, attribute: .height, multiplier: 0.1, constant: 0).isActive = true
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

    private func setupCollectionView() {
        if gameBoard?.superview == nil {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsetsMake(spaceBetweenCollectionViewSections, 0, 0, 0)
            gameBoard = UICollectionView(frame: .zero, collectionViewLayout: layout)
            guard let gameBoard = gameBoard else {
                return
            }
            gameBoard.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseID())
            gameBoard.isScrollEnabled = false
            gameBoard.backgroundColor = .white
            gameBoard.delegate = self
            gameBoard.dataSource = self
            self.view.addSubview(gameBoard)
            gameBoard.isUserInteractionEnabled = false

            gameBoard.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: gameBoard.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: gameBoard.superview, attribute: NSLayoutAttribute.width, multiplier: 0.9, constant: 0).isActive = true
            if playerButtons.count > 1 {
                let bottomPlayerButton = playerButtons[0]
                let topPlayerButton = playerButtons[1]
                NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topPlayerButton, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1, constant: 10).isActive = true
                NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: bottomPlayerButton, attribute: NSLayoutAttribute.topMargin, multiplier: 1, constant: -10).isActive = true
            } else {
                NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: gameBoard.superview, attribute: NSLayoutAttribute.topMargin, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: singlePlayerScoreLabel, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0).isActive = true
            }
        }
    }

    // MARK:- UIBarButton BackAction
    @objc func backAction() {
        let alert = UIAlertController(title: "Are You Sure You Want To Exit?", message: "All data from the current game will be lost.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Exit", style: .default, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

// MARK:- UICollectionViewDataSource
extension GameBoardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    // number of sections defaults to 1 without implementation
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseID(), for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let card = sharedDeck.dealCard() {
            cell.card = card
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell else {
            return
        }
        cell.isChosen = true
        currentSet.append(cell)
        if currentSet.count == 3 {
            guard let card1 = currentSet[0].card, let card2 = currentSet[1].card, let card3 = currentSet[2].card else {
                return
            }
            let set = Set(cards: [card1, card2, card3])
            for button in playerButtons {
                if button.isSelecting {
                    if set.isSet() {
                        button.incrementScore()
                    }
                    button.setState(selected: false)
                }
            }
        }
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension GameBoardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetweenCollectionViewCells
    }
}

// MARK:- GameBoardButtonProtocol
extension GameBoardViewController: GameBoardButtonProtocol {
    /**
     When a player button is pressed: disable all player buttons, enable card selection, and disable the exit button.
     */
    func playerSelecting() {
        for button in playerButtons {
            button.isUserInteractionEnabled = false
        }
        cardSelectionEnabled = true
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }

    /**
     When a player's turn is over: enable all player buttons, unselect cards and disable card selection, enable the exit button.
     */
    func playerStoppedSelecting() {
        for button in playerButtons {
            button.isUserInteractionEnabled = true
        }
        for cardCell in currentSet {
            cardCell.isChosen = false
        }
        cardSelectionEnabled = false
        self.navigationItem.leftBarButtonItem?.isEnabled = true
    }
}
