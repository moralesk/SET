//
//  Deck.swift
//  Set
//
//  Created by Kelly Morales on 4/6/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation

let sharedDeck = Deck()

class Deck: SETValidationProtocol {

    private var cards: [Card] = []
    /// The number of cards remaining in the Deck
    var numberOfCards: Int {
        get {
            return cards.count
        }
    }

    /// Resets the deck to have 81 cards in a random order
    func shuffle() {
        cards.removeAll()
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
            cards.append(unshuffledDeck[randomIndex])
        }
    }

    /// Returns the next optional card in the deck
    func dealCard() -> Card? {
        if cards.count > 0 {
            return cards.removeFirst()
        }
        return nil
    }

    /**
     Returns the first group of cards to be displayed, typically 12 unless a SET doesn't exist, then an extra
     three cards are added until a SET exists in the list.
     */
    func getInitialDeal() -> [Card] {
        if var initialCards = deal(numberOfCards: SETConstants.boardDefaultNumberOfRows * SETConstants.boardDefaultNumberOfCardsPerRow) {
            while !setExists(in: initialCards) {
                if let additionalCards = deal(numberOfCards: 3, dealMaximumPossible: true) {
                    initialCards += additionalCards
                }
            }
            return initialCards
        }
        return []
    }

    /**
     - parameter numberOfCards: the ideal number of cards to be returned
     - parameter dealMaximumPossible: a flag to ask for the maximum number of cards to be returned if the ideal numberOfCards is more than what is left in the deck
     - returns: an optional array of Cards
     */
    func deal(numberOfCards: Int, dealMaximumPossible: Bool = false) -> [Card]? {
        var numCardsToDeal = numberOfCards
        if self.numberOfCards < numCardsToDeal {
            if !dealMaximumPossible {
                return nil
            } else {
                numCardsToDeal = self.numberOfCards
            }
        }

        var cardsToReturn: [Card] = []
        for _ in 0..<numCardsToDeal {
            guard let card = dealCard() else {
                return nil
            }
            cardsToReturn.append(card)
        }
        return cardsToReturn
    }
}
