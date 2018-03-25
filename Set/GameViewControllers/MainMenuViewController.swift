//
//  MainMenuViewController.swift
//  Set
//
//  Created by Kelly Morales on 3/24/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

class MainMenuViewController: UIViewController {

    let greetingLabel = UILabel()
    var playButton: MainSelectionButton?
    var tutorialButton: MainSelectionButton?
    var buttons: [MainSelectionButton] = []
    var addButtonPadding = false

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGreetingLabel()
        setupButtons()
    }

    // MARK: View Builders
    private func setupGreetingLabel() {
        if greetingLabel.superview == nil {
            greetingLabel.font = UIFont.boldSystemFont(ofSize: 26)
            greetingLabel.textAlignment = .center
            greetingLabel.text = "WELCOME TO SET"
            self.view.addSubview(greetingLabel)
            setGreetingConstraints()
        }
    }

    private func setupPlayButton() {
        if playButton?.superview == nil {
            playButton = MainSelectionButton(text: "PLAY GAME")
            guard let playButton = playButton else {
                return
            }
            playButton.addTarget(self, action: #selector(playSelected), for: .touchUpInside)
            self.view.addSubview(playButton)
        }
    }

    private func setupTutorialButton() {
        if tutorialButton?.superview == nil {
            tutorialButton = MainSelectionButton(text: "TUTORIAL")
            guard let tutorialButton = tutorialButton else {
                return
            }
            tutorialButton.addTarget(self, action: #selector(tutorialSelected), for: .touchUpInside)
            self.view.addSubview(tutorialButton)
        }
    }

    // MARK: Constraints
    private func setGreetingConstraints() {
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: greetingLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: greetingLabel.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: greetingLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: greetingLabel.superview, attribute: NSLayoutAttribute.topMargin, multiplier: 1.2, constant: 0)
        let width = NSLayoutConstraint(item: greetingLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: greetingLabel.superview, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: greetingLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: greetingLabel.superview, attribute: NSLayoutAttribute.height, multiplier: 0.1, constant: 0)
        NSLayoutConstraint.activate([centerX, top, width, height])
    }

    private func setPlayButtonConstraints() {
        guard let playButton = playButton, let playButtonIndex = buttons.index(of: playButton) else {
            return
        }
        playButton.activateConstraints()
        if addButtonPadding {
            NSLayoutConstraint(item: playButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: playButton.superview, attribute: NSLayoutAttribute.centerY, multiplier: CGFloat(playButtonIndex + 1)/CGFloat(buttons.count), constant: 20).isActive = true
        } else {
            NSLayoutConstraint(item: playButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: playButton.superview, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        }
    }

    private func setTutorialButtonConstraints() {
        guard let tutorialButton = tutorialButton, let tutorialButtonIndex = buttons.index(of: tutorialButton) else {
            return
        }
        tutorialButton.activateConstraints()
        if addButtonPadding {
            NSLayoutConstraint(item: tutorialButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: tutorialButton.superview, attribute: NSLayoutAttribute.centerY, multiplier: CGFloat(tutorialButtonIndex + 1)/CGFloat(buttons.count), constant: -20).isActive = true
        } else {
            NSLayoutConstraint(item: tutorialButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: tutorialButton.superview, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        }
    }

    // MARK: Helpers

    /// Builds buttons and determines which order they're displayed in the view from top to bottom
    private func setupButtons() {
        setupPlayButton()
        setupTutorialButton()
        guard let playButton = playButton, let tutorialButton = tutorialButton else {
            return
        }
        buttons.removeAll()
        buttons.append(contentsOf: [playButton, tutorialButton])
        addButtonPadding = buttons.count > 1
        updateButtonConstraints()
    }

    private func updateButtonConstraints() {
        setPlayButtonConstraints()
        setTutorialButtonConstraints()
    }

    // MARK: Selectors
    @objc private func playSelected() {
        let numberOfPlayersVC = NumberOfPlayersViewController()
        navigationController?.pushViewController(numberOfPlayersVC, animated: true)
    }

    @objc private func tutorialSelected() {
        
    }
}
