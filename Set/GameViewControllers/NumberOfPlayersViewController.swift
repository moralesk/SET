//
//  NumberOfPlayersViewController.swift
//  Set
//
//  Created by Kelly Morales on 3/24/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

class NumberOfPlayersViewController: UIViewController {

    let promptLabel = UILabel()
    var continueButton: MainSelectionButton?

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPromptLabel()
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
}
