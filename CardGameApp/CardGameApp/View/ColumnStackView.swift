//
//  ColumnStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 14..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ColumnStackView: UIStackView {

    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        let heightOfCard = self.frame.width * 1.27
        self.spacing = -heightOfCard * (7/10)
    }
    
    func add(cards: [Card]) {
        
        for card in cards {
            let cardView = CardImageView(card: card)
            cardView.flip()
            if card === cards.last {
                cardView.flip()
            }
            self.addArrangedSubview(cardView)
        }
    }
}