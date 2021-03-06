//
//  Card.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 3..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class Card : CustomStringConvertible {
    
    //MARK: - Properties
    
    var description: String {
        return "\(self.suit.firstLetter)\(self.rank.description)"
    }
    
    //MARK: Private
    
    private let suit: Suit
    private let rank: Rank
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(suit:Suit, rank:Rank) {
        self.suit = suit
        self.rank = rank
    }
    
    //MARK: Instance
    
    func isSame(rank: Rank) -> Bool {
        return self.rank == rank
    }

    func score() -> Int {
        return self.rank.rawValue * 10 + self.suit.rawValue
    }
    
    static func ==(lhs: Card, rhs: Card?) -> Bool {
        
        guard let rhs = rhs else { return false }
        return lhs.rank == rhs.rank && lhs.suit == rhs.suit
    }
    
    func isA() -> Bool {
        return self.rank == .A
    }
    
    func isK() -> Bool {
        return self.rank == .K
    }
    
    func isMoveableToGoal(_ card: Card?) -> Bool {
        guard let card = card else { return false }
        return isOneStepDownRank(card: card) && isSameSuit(card)
    }
    
    func isMoveableToColumn(_ card: Card?) -> Bool {
        guard let card = card else { return false }
        return isOneStepUpRank(card: card) && isDifferentColor(card: card)
    }
    
    func isOneStepDownRank(card: Card) -> Bool {
        return card.rank.rawValue == self.rank.rawValue - 1
    }
    
    func isOneStepUpRank(card: Card) -> Bool {
        return card.rank.rawValue == self.rank.rawValue + 1
    }
    
    func isDifferentColor(card: Card) -> Bool {
        return card.suit.color() != self.suit.color()
    }
    
    func isSameSuit(_ card: Card) -> Bool {
        return card.suit == self.suit
    }
}
