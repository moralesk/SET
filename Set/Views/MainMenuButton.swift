//
//  MainMenuButton.swift
//  Set
//
//  Created by Kelly Morales on 3/24/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

class MainMenuButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(text: String) {
        super.init(frame: .zero)
        backgroundColor = .purple
        layer.cornerRadius = 3.0
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        setTitleColor(.white, for: .normal)
    }

    func activateConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.superview, attribute: NSLayoutAttribute.width, multiplier: 0.5, constant: 0)
        let height = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self.superview, attribute: NSLayoutAttribute.height, multiplier: 0.1, constant: 0)
        NSLayoutConstraint.activate([centerX, width, height])
    }
}
