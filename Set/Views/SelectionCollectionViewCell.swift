//
//  SelectionCollectionViewCell.swift
//  Set
//
//  Created by Kelly Morales on 3/25/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

/// UICollectionViewCell used in a UICollectionView displaying selectable options, such as the number of players for the game
class SelectionCollectionViewCell: UICollectionViewCell {
    private var labelText: String?
    private let label = UILabel()

    // MARK: Lifecycle Methods
    init(text: String) {
        super.init(frame: .zero)
        initialize(with: text)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.label.textColor = .green
            } else {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.03, execute: {
                    self.label.textColor = .white
                })
            }
        }
    }

    private func initialize() {
        backgroundColor = .purple
        layer.cornerRadius = 3.0
        if label.superview == nil {
            label.text = labelText
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textAlignment = .center
            self.contentView.addSubview(label)
        }
        updateLabelConstraints()
    }

    func initialize(with text: String) {
        initialize()
        if label.superview != nil {
            labelText = text
            label.text = labelText
        }
    }

    private func updateLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: label.superview, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: label.superview, attribute: .height, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([width, height])
    }

    static func reuseID() -> String {
        return "SelectionCell"
    }
}
