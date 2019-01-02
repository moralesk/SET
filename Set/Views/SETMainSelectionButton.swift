//
//  SETMainSelectionButton.swift
//  Set
//
//  Created by Kelly Morales on 3/24/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

/**
 The button used for most common non-gampeplay selections
 */
class SETMainSelectionButton: UIButton {

    var width: NSLayoutConstraint?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(frame: .zero)
        initialize()
    }

    init(text: String) {
        super.init(frame: .zero)
        initialize()
        setTitle(text, for: .normal)
    }

    private func initialize() {
        backgroundColor = .purple
        layer.cornerRadius = 3.0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel?.numberOfLines = 1
        setTitleColor(.white, for: .normal)
        setTitleColor(.green, for: .highlighted)
    }

    /// Activates centerX, width, and height
    func activateConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        width = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.superview, attribute: NSLayoutAttribute.width, multiplier: 0.5, constant: 0)
        let height = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self.superview, attribute: NSLayoutAttribute.height, multiplier: 0.1, constant: 0)
        guard let width = width else {
            NSLog("SETMainSelectionButton width not initialized properly")
            return
        }
        NSLayoutConstraint.activate([centerX, width, height])
    }
}
