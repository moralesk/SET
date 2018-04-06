//
//  Deck.swift
//  Set
//
//  Created by Kelly Morales on 4/6/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation

class Deck {

    private var currentDeck: [Card] = []

    init() {
        shuffle()
    }

    /// Resets the deck to have 81 cards in a random order
    func shuffle() {
        var unshuffledDeck: [Card] = []
        for i in 0..<Card.Color.count.rawValue {
            for j in 0..<Card.Shape.count.rawValue {
                for k in 0..<Card.Fill.count.rawValue {
                    for l in 0..<Card.Count.count.rawValue {
                        guard let color = Card.Color(rawValue: i), let shape = Card.Shape(rawValue: j), let fill = Card.Fill(rawValue: k), let count = Card.Count(rawValue: l) else {
                            return
                        }
                        let cardToAdd = Card(with: color, shape: shape, fill: fill, count: count)
                        unshuffledDeck.append(cardToAdd)
                    }
                }
            }
        }
        for _ in 0..<unshuffledDeck.count {
            let randomIndex = Int(arc4random_uniform(UInt32(unshuffledDeck.count)))
            currentDeck.append(unshuffledDeck[randomIndex])
        }
    }

    /// Returns an optional first card in the deck
    func getCard() -> Card? {
        if currentDeck.count > 0 {
            return currentDeck.removeFirst()
        }
        return nil
    }
}
