//
//  UIImageExtension.swift
//  Manga Demo
//
//  Created by Thien Vu Le on Jul/10/18.
//  Copyright © 2018 Thien Vu Le. All rights reserved.
//

import UIKit

extension UIImage {
  class func imageWithTextView(textView: UITextView) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(textView.bounds.size, false, 0.0)
    textView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}

