//
//  PublicationCell.swift
//  Manga Demo
//
//  Created by Thien Vu Le on Jul/9/18.
//  Copyright © 2018 Thien Vu Le. All rights reserved.
//

import UIKit

class PublicationCell: UICollectionViewCell {
  
  var imageView: UIImageView

  override init(frame: CGRect) {
    imageView              = UIImageView()
    super.init(frame: frame)
    isAccessibilityElement = true
    contentView.frame     = self.bounds
    imageView.contentMode  = .scaleAspectFit
    imageView.frame        = self.bounds
    contentView.addSubview(imageView)
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    contentView.frame = self.bounds
    imageView.frame   = self.bounds
    imageView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
  }
}
