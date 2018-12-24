//
//  Set.swift
//  Set
//
//  Created by Kelly Morales on 12/24/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation

/// Object containing an array of three Card objects, and can determine if those three Cards make a SET
class Set: NSObject {

    private var cards: [Card]?

    init(cards: [Card]) {
        if cards.count == 3 {
            self.cards = cards
        } else {
            self.cards = nil
        }
    }

    func isSet() -> Bool {
        guard let cards = cards else {
            return false
        }

        if cards.count != 3 {
            return false
        }

        let count = (areCardColorsValid() ? 1 : 0)
            + (areCardShapesValid() ? 1 : 0)
            + (areCardFillsValid() ? 1 : 0)
            + (areCardCountsValid() ? 1: 0)

        // if only one attribute, or if all but one attribute are the same then there is a successful SET
        return count == 4
    }

    // MARK:- Private Validation functions
    private func areCardColorsValid() -> Bool {
        guard let cards = cards else {
            return false
        }
        return (cards[0].color == cards[1].color && cards[1].color == cards[2].color)
            || (cards[0].color != cards[1].color && cards[1].color != cards[2].color && cards[0].color != cards[2].color)
    }

    private func areCardShapesValid() -> Bool {
        guard let cards = cards else {
            return false
        }
        return (cards[0].shape == cards[1].shape && cards[1].shape == cards[2].shape)
            || (cards[0].shape != cards[1].shape && cards[1].shape != cards[2].shape && cards[0].shape != cards[2].shape)
    }

    private func areCardFillsValid() -> Bool {
        guard let cards = cards else {
            return false
        }
        return (cards[0].fill == cards[1].fill && cards[1].fill == cards[2].fill)
            || (cards[0].fill != cards[1].fill && cards[1].fill != cards[2].fill && cards[0].fill != cards[2].fill)
    }

    private func areCardCountsValid() -> Bool {
        guard let cards = cards else {
            return false
        }
        return (cards[0].count == cards[1].count && cards[1].count == cards[2].count)
            || (cards[0].count != cards[1].count && cards[1].count != cards[2].count && cards[0].count != cards[2].count)
    }
}
