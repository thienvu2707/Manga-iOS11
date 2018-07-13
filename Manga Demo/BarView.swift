//
//  BarView.swift
//  Manga Demo
//
//  Created by Thien Vu Le on Jul/12/18.
//  Copyright © 2018 Thien Vu Le. All rights reserved.
//

import UIKit

open class BarView: UIView {

  let label: UILabel!
  public weak var delegate: UIViewController?
  
  public init() {
    label = UILabel()
    super.init(frame: CGRect.zero)
    autoresizingMask = [.flexibleWidth]
    isOpaque = false
    backgroundColor = UIColor.clear
    //
    let fontSize = self.label.font.pointSize;
    label.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
    label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    label.alpha = 0.4
    label.textAlignment = .center
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    addSubview(label)
  }
  
  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open override func updateConstraints() {
    super.updateConstraints()
    guard let height = delegate?.navigationController?.navigationBar.frame.height else {
      return
    }
    removeConstraints(constraints)
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  public func setLabel(title: String?) {
    label.text = title
  }

}
