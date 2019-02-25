//
//  ViewController.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet weak var pileStackView: BackPositionStackView!
    @IBOutlet weak var previewStackView: PositionStackView!
    @IBOutlet weak var goalsStackView: UIStackView!
    @IBOutlet weak var columnsStackView: UIStackView!
    
    //MARK: Instance
    
    var klondike: Klondike = Klondike()
    
    //MARK: - Methods
    //MARK: Setting
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "bg_pattern") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCardGameStackView),
                                               name: .cardStackDidChange,
                                               object: nil)
        
        mappingViewsAndTags()
        klondike.setUp()
    }
    
    //MARK: Notification
    
    @objc private func updateCardGameStackView(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let cards = userInfo[UserInfoKey.cards] as? [Card],
            let stackType = userInfo[UserInfoKey.stackType] as? ObjectIdentifier,
            let typeTag = Mapper.map[stackType] else { return }
        let position = (userInfo[UserInfoKey.position] as? Int) ?? 0
        let tag = typeTag + position
        guard let cardGameStackView = self.view.viewWithTag(tag) as? CardGameStackView & UIStackView else { return }
        
        cardGameStackView.update(cards: cards)
    }
    
    //MARK: IBAction
    
    @IBAction func tapPileStackView(_ sender: Any) {
        self.klondike.flipCardsFromPileToPreview()
    }
    
    //MARK: Motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            klondike.reset()
        }
    }
    
    //MARK: Private
    
    private func mappingViewsAndTags() {
        guard let pileTag = Mapper.map[ObjectIdentifier(Pile.self)],
            let previewTag = Mapper.map[ObjectIdentifier(Preview.self)],
            let goalTag = Mapper.map[ObjectIdentifier(Goal.self)],
            let columnTag = Mapper.map[ObjectIdentifier(Column.self)] else { return }
        
        pileStackView.tag = pileTag
        previewStackView.tag = previewTag
        goalsStackView.addTagToArrangedSubviews(goalTag)
        columnsStackView.addTagToArrangedSubviews(columnTag)
    }
}

extension UIStackView {
    
    func addTagToArrangedSubviews(_ superTag: Int) {
        for index in arrangedSubviews.startIndex..<arrangedSubviews.endIndex {
            let position = index + 1
            arrangedSubviews[index].tag = superTag + position
        }
    }
}

protocol CardGameStackView {
    func add(cards: [Card])
}

extension CardGameStackView where Self: UIStackView {
    
    private func removeAllSubviews() {
        for subview in self.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
    
    func update(cards: [Card]) {
        removeAllSubviews()
        add(cards: cards)
    }
}
