//
//  SetFinderProtocol.swift
//  Set
//
//  Created by Kelly Morales on 12/26/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation

protocol SetFinderProtocol {
    /// Determines if a set exists within a given list of Cards
    func setExists(in cards: [Card]) -> Bool

    /// Determines if the given array of 3 cards is a SET
    func isSet(_ cards: [Card]) -> Bool
}

extension SetFinderProtocol {
    func setExists(in cards: [Card]) -> Bool {
        if cards.count < 3 {
            return false
        }

        for i in 0...cards.count - 3 {
            for j in i+1...cards.count - 2 {
                // For any two cards, there is only one that will complete their set
                // There is no reason to loop to the last card in the deck since it will be accounted for by the other pairs
                if let lastCard = findLastCard(for: [cards[i], cards[j]]) {
                    if cards.contains(lastCard) {
                        return true
                    }
                }
            }
        }
        return false
    }

    func isSet(_ cards: [Card]) -> Bool {
        if cards.count != 3 {
            return false
        }
        
        if cards[0] == cards[1] && cards[1] == cards[2] {
            return false
        }
        
        return areCardColorsValid(cards) && areCardShapesValid(cards) && areCardFillsValid(cards) && areCardCountsValid(cards)
    }
    
    // MARK:- Private Validation functions
    // These functions take whichever attribute of a group of cards and determines if they're either all the same
    // or all different, otherwise they will not create a set
    private func areCardColorsValid(_ cards: [Card]) -> Bool {
        if cards.count != 3 {
            return false
        }
        return (cards[0].color == cards[1].color && cards[1].color == cards[2].color)
            || (cards[0].color != cards[1].color
                && cards[1].color != cards[2].color
                && cards[0].color != cards[2].color)
    }
    
    private func areCardShapesValid(_ cards: [Card]) -> Bool {
        if cards.count != 3 {
            return false
        }
        return (cards[0].shape == cards[1].shape && cards[1].shape == cards[2].shape)
            || (cards[0].shape != cards[1].shape
                && cards[1].shape != cards[2].shape
                && cards[0].shape != cards[2].shape)
    }
    
    private func areCardFillsValid(_ cards: [Card]) -> Bool {
        if cards.count != 3 {
            return false
        }
        return (cards[0].fill == cards[1].fill && cards[1].fill == cards[2].fill)
            || (cards[0].fill != cards[1].fill
                && cards[1].fill != cards[2].fill
                && cards[0].fill != cards[2].fill)
    }
    
    private func areCardCountsValid(_ cards: [Card]) -> Bool {
        if cards.count != 3 {
            return false
        }
        return (cards[0].count == cards[1].count && cards[1].count == cards[2].count)
            || (cards[0].count != cards[1].count
                && cards[1].count != cards[2].count
                && cards[0].count != cards[2].count)
    }
    
    /**
     - parameter pair: an array of two cards
     - returns: the card that will complete the set given the two cards
     */
    private func findLastCard(for pair: [Card]) -> Card? {
        if pair.count != 2 {
            return nil
        }
        let lastCardColor = Card.Color(rawValue: getLastEnumOption(card1Option: pair[0].color.rawValue, card2Option: pair[1].color.rawValue))
        let lastCardShape = Card.Shape(rawValue: getLastEnumOption(card1Option: pair[0].shape.rawValue, card2Option: pair[1].shape.rawValue))
        let lastCardFill = Card.Fill(rawValue: getLastEnumOption(card1Option: pair[0].fill.rawValue, card2Option: pair[1].fill.rawValue))
        let lastCardCount = Card.Count(rawValue: getLastEnumOption(card1Option: pair[0].count.rawValue, card2Option: pair[1].count.rawValue))

        guard let color = lastCardColor, let shape = lastCardShape, let fill = lastCardFill, let count = lastCardCount else {
            return nil
        }

        let lastCard = Card(with: color, shape: shape, fill: fill, count: count)
        return lastCard
    }

    /// Helper function to return an Int that corresponds to an enum option based on the options (parameters) already in use by a pair of Cards
    private func getLastEnumOption(card1Option: Int, card2Option: Int) -> Int {
        if card1Option == card2Option {
            return card1Option
        }
        let possibleCardOptions = [0, 1, 2]
        return possibleCardOptions.filter { $0 != card1Option && $0 != card2Option } [0]
    }
}
