//
//  FoundationPilesViewController.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class FoundationPilesViewController: UIViewController {
  var foundationPilesViewModel: FoundationPilesViewModel! {
    didSet {
      self.foundationPilesViewModel.delegate = self
      initialize()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

private extension FoundationPilesViewController {
  func initialize() {
    configueFoundationPilesView()
  }
  
  func configueFoundationPilesView() {
    foundationPilesViewModel.addCardViewModels()
  }
}

// MARK:- FoundationPilesViewControllerDelegate
extension FoundationPilesViewController: FoundationPilesViewControllerDelegate {
  func setEmptyView(_ pileIndex: Int) {
    let foundationPileViewController = FoundationPileViewController()
    foundationPileViewController.addView(pileIndex: pileIndex, with: nil)
    addChildController(asChildViewController: foundationPileViewController)
  }
}

// MARK:- ChildViewController Life Cycle
private extension FoundationPilesViewController {
  func addChildController(asChildViewController viewController: UIViewController) {
    addChildViewController(viewController)
    view.addSubview(viewController.view)
    viewController.didMove(toParentViewController: self)
  }
}

