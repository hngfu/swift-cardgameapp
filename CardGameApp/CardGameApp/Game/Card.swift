//
//  Card.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 11. 24..
//  Copyright © 2017년 심 승민. All rights reserved.
//

import Foundation
import UIKit

// Card = Rank + Suit
class Card {
    private let shape: Shape
    private let number: Number
    private var isFaceUp: Bool
    private lazy var frontImage = UIImage(imageLiteralResourceName: self.description)
    init(_ shape: Shape, _ number: Number) {
        self.shape = shape
        self.number = number
        self.isFaceUp = false
    }

}

extension Card {
    func showCard() -> UIImage? {
        if isFaceUp {
            return frontImage
        }
        return nil
    }

    // 카드 앞뒷면 뒤집음
    func turnOver() {
        if !isFaceUp {
            self.isFaceUp = true
        }
    }

}

// 카드 한 장 출력 포맷. 모양+숫자 형태.
extension Card: CustomStringConvertible {
    var description: String {
        return self.shape.description + self.number.description
    }

}

// 카드를 비교할 경우, 카드의 숫자를 비교. (Shape과 Number의 캡슐화를 위함.)
extension Card: Equatable, Comparable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        guard lhs.number == rhs.number else { return false }
        return true
    }

    static func < (lhs: Card, rhs: Card) -> Bool {
        guard lhs.number < rhs.number else { return false }
        return true
    }

}