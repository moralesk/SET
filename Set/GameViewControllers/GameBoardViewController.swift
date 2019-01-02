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
class GameBoardViewController: UIViewController, SETGameBoardProtocol {

    var gameBoard: UICollectionView?

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

    private var dataSourceDelegate: SETGameBoardDataSourceProtocol?
    private var currentCards: [SETCard] = []
    lazy private var currentSet: [SETCardCollectionViewCell] = []

    // MARK:- Lifecycle Methods
    init(numberOfPlayers: Int) {
        super.init(nibName: nil, bundle: nil)
        if numberOfPlayers == 1 {
            self.dataSourceDelegate = SETSinglePlayerDataSource()
        } else if numberOfPlayers > 1 {
            self.dataSourceDelegate = SETMultiPlayerDataSource(numberOfPlayers: numberOfPlayers)
        }
        dataSourceDelegate?.gameBoardDelegate = self
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
        currentCards = sharedDeck.getInitialDeal()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSourceDelegate?.setupPlayerElements()
        setupCardCollectionView()
    }

    private func setupCardCollectionView() {
        if gameBoard?.superview == nil {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsetsMake(spaceBetweenCollectionViewSections, 0, 0, 0)
            gameBoard = UICollectionView(frame: .zero, collectionViewLayout: layout)
            guard let gameBoard = gameBoard else {
                return
            }
            gameBoard.register(SETCardCollectionViewCell.self, forCellWithReuseIdentifier: SETCardCollectionViewCell.reuseID())
            gameBoard.isScrollEnabled = false
            gameBoard.backgroundColor = .white
            gameBoard.delegate = self
            gameBoard.dataSource = self
            self.view.addSubview(gameBoard)

            gameBoard.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: gameBoard.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: gameBoard, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: gameBoard.superview, attribute: NSLayoutAttribute.width, multiplier: 0.9, constant: 0).isActive = true
            dataSourceDelegate?.completeGameBoardConstraints()
        }
    }

    // MARK:- Helpers
    private func resetCurrentSet() {
        for cardCell in currentSet {
            cardCell.isChosen = false
        }
        currentSet.removeAll()
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
extension GameBoardViewController: UICollectionViewDataSource, SETValidationProtocol {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // The number of cards per row should divide evenly into the number of cards we are tracking
        // if not, we add another section for the remaining cards (this should only happen when the deck
        // is running out of cards to deal)
        let remainder = currentCards.count % SETConstants.boardDefaultNumberOfCardsPerRow
        var numSections = currentCards.count / SETConstants.boardDefaultNumberOfCardsPerRow
        if remainder != 0 {
            numSections += 1
        }
        return numSections
    }

    // number of sections defaults to 1 without implementation
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Should usually be boardDefaultNumberOfCardsPerRow, unless we have reached the end of the deck,
        // then we'll display an equal number of cards until we can't, in which case we'll display the remainder
        if section == numberOfSections(in: collectionView) - 1 {
            let remainder = currentCards.count % SETConstants.boardDefaultNumberOfCardsPerRow
            if remainder != 0 {
                return remainder
            }
        }
        return SETConstants.boardDefaultNumberOfCardsPerRow
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SETCardCollectionViewCell.reuseID(), for: indexPath) as? SETCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        // uses 2d array to grab card from 1d array
        cell.card = currentCards[indexPath.section * SETConstants.boardDefaultNumberOfCardsPerRow + indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SETCardCollectionViewCell else {
            return
        }
        cell.isChosen = true
        currentSet.append(cell)
        if currentSet.count == 3 {
            guard let card1 = currentSet[0].card, let card2 = currentSet[1].card, let card3 = currentSet[2].card else {
                return
            }
            let set = [card1, card2, card3]
            dataSourceDelegate?.processSet(valid: isSet(set))
            resetCurrentSet()
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
