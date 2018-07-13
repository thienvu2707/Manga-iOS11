//
//  EpubViewController.swift
//  Manga Demo
//
//  Created by Thien Vu Le on Jul/10/18.
//  Copyright © 2018 Thien Vu Le. All rights reserved.
//

import UIKit
import R2Shared
import R2Navigator

class EpubViewController: UIViewController {
  
  var stackView          : UIStackView!
  let navigator          : NavigatorViewController!
  let fixedTopBar        : BarView!
  let fixedBottomBar     : BarView!
  var tableOfContentsTVC : TableOfContentsTableViewController!
//  var popoverUserconfigurationAnchor: UIBarButtonItem?
  
  init(with publication: Publication, atIndex index: Int, progression: Double?){
    stackView            = UIStackView(frame: UIScreen.main.bounds)
    navigator            = NavigatorViewController(for: publication, initialIndex: index, initialProgression: progression)
    fixedTopBar          = BarView()
    fixedBottomBar       = BarView()
    
    tableOfContentsTVC = TableOfContentsTableViewController(for: navigator.getTableOfContents(), callWhenDismissed: navigator.displaySpineItem(with:))
    super.init(nibName: nil, bundle: nil)
  }
  
  deinit {
    navigator.userSettings.save()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view.backgroundColor       = .white
    stackView.axis             = .vertical
    stackView.distribution     = .fill
    stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

    stackView.addArrangedSubview(fixedTopBar)
    stackView.addArrangedSubview(navigator.view)
    stackView.addArrangedSubview(fixedBottomBar)

    view.addSubview(stackView)
    
    
    fixedTopBar.delegate    = self
    fixedBottomBar.delegate = self
    navigator.delegate      = self
  }

    override func viewDidLoad() {
      super.viewDidLoad()

      fixedTopBar.setLabel(title: navigator.publication.metadata.title)
      fixedBottomBar.setLabel(title: "")
      navigationController?.setNavigationBarHidden(true, animated: true)
      
      //MARK: Later add button on navigation bar TABLE OF CONTENT AND USER SETTING
      var barButtons = [UIBarButtonItem]()
      
      if navigator.getTableOfContents().count > 0 {
        //Show tableView of content
        let spineItemButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menuIcon"), style: .plain, target: self, action: #selector(presentTableofContents))
        
        barButtons.append(spineItemButton)
      }
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.hidesBarsOnTap = true
//    toggleFixBars()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    navigationController?.hidesBarsOnTap = false
  }
  
  override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    fixedTopBar.setNeedsUpdateConstraints()
    fixedBottomBar.setNeedsUpdateConstraints()
  }
  
  override open var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return UIStatusBarAnimation.fade
  }
  
  open override var prefersStatusBarHidden: Bool {
    return true
  }
}

extension EpubViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}


extension EpubViewController {
  @objc func presentTableofContents() {
    
    let backItem                     = UIBarButtonItem()
    backItem.title                   = ""
    navigationItem.backBarButtonItem = backItem
    navigationController?.pushViewController(tableOfContentsTVC, animated: true)
  }
}


// MARK: - Delegate of the NavigatorViewController (R2Navigator).
extension EpubViewController: NavigatorDelegate {
  
  func middleTapHandler() {
    guard let state = navigationController?.navigationBar.isHidden else {
      return
    }
    navigationController?.setNavigationBarHidden(!state, animated: true)
  }
  
  // The publication is being closed, provide info for saving progress.
  func willExitPublication(documentIndex: Int, progression: Double?) {
    guard let publicationIdentifier = navigator.publication.metadata.identifier else {
      return
    }
    let userDefaults = UserDefaults.standard
    // Save current publication's document's.
    // (<=> the spine item)
    userDefaults.set(documentIndex, forKey: "\(publicationIdentifier)-document")
    // Save current publication's document's progression.
    // (<=> the position in the spine item)
    userDefaults.set(progression, forKey: "\(publicationIdentifier)-documentProgression")
  }
}
