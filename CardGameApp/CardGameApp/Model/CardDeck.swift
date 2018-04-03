//
//  CardDeck.swift
//  CardGame
//
//  Created by jack on 2018. 1. 8..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol BaseControl {
    mutating func shuffle()
    mutating func removeOne() -> Card
    mutating func reset()
    func isEmpty() -> Bool
    mutating func generateOneStack(numberOfStack : Int) -> [Card]
}

struct CardDeck : BaseControl {
    private var deck : [Card] = []
    private static var instance : CardDeck = CardDeck()
    
    static func shared() -> CardDeck {
        return instance
    }
    
    private init() {
        for oneSuit in Card.Suits.allCases {
            for oneRank in Card.Ranks.allCases {
                self.deck.append(Card(oneSuit, oneRank))
            }
        }
    }
    
    func isEmpty() -> Bool {
        return self.deck.count == 0
    }
    
    func count() -> Int {
        return self.deck.count
    }
    
    mutating func shuffle() {
        for _ in 0..<self.deck.count {
            do {
                self.deck.sort { (_,_) in arc4random() < arc4random() }
            }
        }
    }
    
    mutating func removeOne() -> Card {
        let topCard = self.deck.removeLast()
        NotificationCenter.default.post(name: .didTapCardDeck, object: self, userInfo: [Key.Observer.openedCard.name: topCard])
        return topCard
    }
    
    mutating func reset() {
        self.deck = CardDeck().deck
    }
    
    mutating func generateOneStack(numberOfStack : Int) -> [Card] {
        var oneStack : [Card] = []
        for _ in 0...numberOfStack {
            oneStack.append(self.deck.removeLast())
        }
//        oneStack.append(self.deck.removeLast().changeSide())
        return oneStack
    }
    
}

