//
//  CardImageView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 31..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class CardImageView: UIImageView {

    //MARK: - Properties
    //MARK: Private
    
    private var backImage: UIImage? = UIImage(named: "card_back")
    private var isFront: Bool = false
    
    //MARK: - Methods
    //MARK: Initialization
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        addAspectRatioConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addAspectRatioConstraint()
    }
    
    convenience init(card: Card) {
        let image = UIImage(named: card.description)
        self.init(image: image)
    }
    
    //MARK: Private
    
    private func addAspectRatioConstraint() {
        
        let aspectRatioConstraint = NSLayoutConstraint(item: self,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: self,
                                                       attribute: .width,
                                                       multiplier: 1.27,
                                                       constant: 0)
        self.addConstraint(aspectRatioConstraint)
    }
    
    //MARK: Instance
    
    func flip() {
        self.isFront = !self.isFront
        self.backImage <> self.image
    }
}

infix operator <>

func <>(lhs: inout UIImage?, rhs: inout UIImage?) {
    
    let temp = lhs
    lhs = rhs
    rhs = temp
}