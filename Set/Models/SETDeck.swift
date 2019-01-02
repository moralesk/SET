//
//  SETDeck.swift
//  Set
//
//  Created by Kelly Morales on 4/6/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation

let sharedDeck = SETDeck()

class SETDeck: SETValidationProtocol {

    private var cards: [SETCard] = []
    /// The number of cards remaining in the Deck
    var numberOfCards: Int {
        get {
            return cards.count
        }
    }

    /// Resets the deck to have 81 cards in a random order
    func shuffle() {
        cards.removeAll()
        var unshuffledDeck: [SETCard] = []
        for i in 0..<SETCard.Color.count.rawValue {
            for j in 0..<SETCard.Shape.count.rawValue {
                for k in 0..<SETCard.Fill.count.rawValue {
                    for l in 0..<SETCard.Count.count.rawValue {
                        guard let color = SETCard.Color(rawValue: i), let shape = SETCard.Shape(rawValue: j), let fill = SETCard.Fill(rawValue: k), let count = SETCard.Count(rawValue: l) else {
                            return
                        }
                        let cardToAdd = SETCard(with: color, shape: shape, fill: fill, count: count)
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
    func dealCard() -> SETCard? {
        if cards.count > 0 {
            return cards.removeFirst()
        }
        return nil
    }

    /**
     Returns the first group of cards to be displayed, typically 12 unless a SET doesn't exist, then an extra
     three cards are added until a SET exists in the list.
     */
    func getInitialDeal() -> [SETCard] {
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
    func deal(numberOfCards: Int, dealMaximumPossible: Bool = false) -> [SETCard]? {
        var numCardsToDeal = numberOfCards
        if self.numberOfCards < numCardsToDeal {
            if !dealMaximumPossible {
                return nil
            } else {
                numCardsToDeal = self.numberOfCards
            }
        }

        var cardsToReturn: [SETCard] = []
        for _ in 0..<numCardsToDeal {
            guard let card = dealCard() else {
                return nil
            }
            cardsToReturn.append(card)
        }
        return cardsToReturn
    }
}
