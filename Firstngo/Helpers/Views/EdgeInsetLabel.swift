//
//  EdgeInsetLabel.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/10/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

class EdgeInsetLabel: UILabel {

    var textInsets = UIEdgeInsets.zero {
           didSet { invalidateIntrinsicContentSize() }
       }

       override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
           let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
           let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                             left: -textInsets.left,
                                             bottom: -textInsets.bottom,
                                             right: -textInsets.right)
           return textRect.inset(by: invertedInsets)
       }

       override func drawText(in rect: CGRect) {
           super.drawText(in: rect.inset(by: textInsets))
       } 
}
