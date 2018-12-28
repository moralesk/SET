//
//  NumberOfPlayersViewController.swift
//  Set
//
//  Created by Kelly Morales on 3/24/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

/**
 View controller displaying the options for the number of players to play the game
 */
class NumberOfPlayersViewController: UIViewController {

    /// prompt for selecting number of players
    private let promptLabel = UILabel()
    private let maxNumberOfPlayers: Int = 4
    /// collection view for options of choosing number of players
    private var playerSelectionView: UICollectionView?
    private var collectionViewCellWidth: CGFloat {
        get {
            return self.view.bounds.height * 0.1
        }
    }
    private let spaceBetweenCollectionViewCells: CGFloat = 5.0
    private var numberOfPlayers: Int?
    private var continueButton: MainSelectionButton?

    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPromptLabel()
        setupCollectionView()
        setupContinueButton()
    }

    // MARK:- View Setup
    // MARK: PromptLabel
    private func setupPromptLabel() {
        if promptLabel.superview == nil {
            promptLabel.font = UIFont.systemFont(ofSize: 24)
            promptLabel.textAlignment = .center
            promptLabel.numberOfLines = 0
            promptLabel.lineBreakMode = .byWordWrapping
            promptLabel.text = "Select the Number of Participants"
            self.view.addSubview(promptLabel)
            setPromptConstraints()
        }
    }

    private func setPromptConstraints() {
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: promptLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: promptLabel.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: promptLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: promptLabel.superview, attribute: NSLayoutAttribute.topMargin, multiplier: 2, constant: 0)
        let width = NSLayoutConstraint(item: promptLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: promptLabel.superview, attribute: NSLayoutAttribute.width, multiplier: 0.85, constant: 0)
        let height = NSLayoutConstraint(item: promptLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: promptLabel.superview, attribute: NSLayoutAttribute.height, multiplier: 0.13, constant: 0)
        NSLayoutConstraint.activate([centerX, top, width, height])
    }

    // MARK: CollectionView
    private func setupCollectionView() {
        if playerSelectionView?.superview == nil {
            let layout = UICollectionViewFlowLayout()
            playerSelectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            guard let playerSelectionView = playerSelectionView else {
                return
            }
            playerSelectionView.register(SelectionCollectionViewCell.self, forCellWithReuseIdentifier: SelectionCollectionViewCell.reuseID())
            playerSelectionView.isScrollEnabled = false
            playerSelectionView.backgroundColor = .white
            playerSelectionView.delegate = self
            playerSelectionView.dataSource = self
            self.view.addSubview(playerSelectionView)

            playerSelectionView.translatesAutoresizingMaskIntoConstraints = false
            let centerX = NSLayoutConstraint(item: playerSelectionView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: playerSelectionView.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
            let top = NSLayoutConstraint(item: playerSelectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: promptLabel, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1, constant: 20)
            let width = NSLayoutConstraint(item: playerSelectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: playerSelectionView.superview, attribute: NSLayoutAttribute.width, multiplier: 0.85, constant: 0)
            let height = NSLayoutConstraint(item: playerSelectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: playerSelectionView.superview, attribute: NSLayoutAttribute.height, multiplier: 0.2, constant: 10)
            NSLayoutConstraint.activate([centerX, top, width, height])
        }
    }

    // MARK: ContinueButton
    private func setupContinueButton() {
        if continueButton?.superview == nil {
            continueButton = MainSelectionButton()
            guard let continueButton = continueButton else {
                return
            }
            continueButton.alpha = 0.0
            continueButton.isUserInteractionEnabled = false
            continueButton.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
            self.view.addSubview(continueButton)
            setContinueButtonConstraints()
        }
    }

    private func setContinueButtonConstraints() {
        guard let continueButton = continueButton else {
            return
        }
        continueButton.activateConstraints()
        continueButton.width?.isActive = false
        NSLayoutConstraint(item: continueButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: playerSelectionView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: continueButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: continueButton.superview, attribute: NSLayoutAttribute.width, multiplier: 0.85, constant: 0).isActive = true
    }

    // MARK:- Selectors
    @objc private func continueAction() {
        guard let num = numberOfPlayers else {
            return
        }
        let gameBoardVC = GameBoardViewController(numberOfPlayers: num)
        sharedDeck.shuffle()
        navigationController?.pushViewController(gameBoardVC, animated: true)
    }
}

// MARK:- UICollectionViewDelegate
extension NumberOfPlayersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        numberOfPlayers = indexPath.row + 1
        guard let continueButton = continueButton, let numberOfPlayers = numberOfPlayers else {
            return
        }
        if continueButton.alpha == 0.0 {
            UIView.animate(withDuration: 0.5, animations: {
                continueButton.alpha = 1.0
                continueButton.isUserInteractionEnabled = true
            })
        }
        continueButton.setTitle("Continue With \(numberOfPlayers) Player\(numberOfPlayers > 1 ? "s" : "")", for: UIControlState())
    }
}

// MARK:- UICollectionViewDataSource
extension NumberOfPlayersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxNumberOfPlayers
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectionCollectionViewCell.reuseID(), for: indexPath) as? SelectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.initialize(with: "\(indexPath.row + 1)")
        return cell
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension NumberOfPlayersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetweenCollectionViewCells
    }
}
