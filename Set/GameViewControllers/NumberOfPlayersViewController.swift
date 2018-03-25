//
//  NumberOfPlayersViewController.swift
//  Set
//
//  Created by Kelly Morales on 3/24/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

class NumberOfPlayersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let promptLabel = UILabel()
    let maxNumberOfPlayers: Int = 4
    var playerSelectionView: UICollectionView?
    var continueButton: MainSelectionButton?

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPromptLabel()
        setupCollectionView()
    }

    // MARK: View Setup
    private func setupPromptLabel() {
        if promptLabel.superview == nil {
            promptLabel.font = UIFont.systemFont(ofSize: 24)
            promptLabel.textAlignment = .center
            promptLabel.text = "Select the Number of Participants"
            self.view.addSubview(promptLabel)
            setPromptConstraints()
        }
    }

    private func setPromptConstraints() {
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: promptLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: promptLabel.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: promptLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: promptLabel.superview, attribute: NSLayoutAttribute.topMargin, multiplier: 2, constant: 0)
        let width = NSLayoutConstraint(item: promptLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: promptLabel.superview, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: promptLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: promptLabel.superview, attribute: NSLayoutAttribute.height, multiplier: 0.1, constant: 0)
        NSLayoutConstraint.activate([centerX, top, width, height])
    }
    
    private func setupCollectionView() {
        if playerSelectionView?.superview == nil {
            let layout = UICollectionViewFlowLayout()
            playerSelectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            guard let playerSelectionView = playerSelectionView else {
                return
            }
            playerSelectionView.register(SelectionCollectionViewCell.self, forCellWithReuseIdentifier: "SelectionCell")
            playerSelectionView.isScrollEnabled = false
            playerSelectionView.backgroundColor = .white
            playerSelectionView.delegate = self
            playerSelectionView.dataSource = self
            self.view.addSubview(playerSelectionView)
            playerSelectionView.translatesAutoresizingMaskIntoConstraints = false
            let centerX = NSLayoutConstraint(item: playerSelectionView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: playerSelectionView.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
            let top = NSLayoutConstraint(item: playerSelectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: promptLabel, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1, constant: 40)
            let width = NSLayoutConstraint(item: playerSelectionView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: playerSelectionView.superview, attribute: NSLayoutAttribute.width, multiplier: 0.85, constant: 0)
            let height = NSLayoutConstraint(item: playerSelectionView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: playerSelectionView.superview, attribute: NSLayoutAttribute.height, multiplier: 0.1, constant: 0)
            NSLayoutConstraint.activate([centerX, top, width, height])
        }
    }
    
    // MARK: UICollectionViewDataSource
    // number of sections defaults to 1 without implementation
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxNumberOfPlayers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCell", for: indexPath) as? SelectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.initialize(with: "\(indexPath.row + 1)")
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.view.bounds.height * 0.1
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}
