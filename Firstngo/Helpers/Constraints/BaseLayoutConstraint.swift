//
//  BaseLayoutConstraint.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/19/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

@IBDesignable class BaseLayoutConstraint: NSLayoutConstraint {
    
    @IBInspectable var phoneXConstant: CGFloat = 1 {
        didSet {
            updateConstant(constant: phoneXConstant)
        }
    }
    
    @IBInspectable var pluseConstantForiPhone: CGFloat = 1 {
        didSet {
            updateConstant(constant: pluseConstantForiPhone)
        }
    }
    
    @IBInspectable var phone6Constant: CGFloat = 1 {
        didSet {
            updateConstant(constant: phone6Constant)
        }
    }
    
    @IBInspectable var XsMaxConstantForiPhone: CGFloat = 1 {
        didSet {
            updateConstant(constant: XsMaxConstantForiPhone)
        }
    }
    
    @IBInspectable var phone5Constant: CGFloat = 1 {
        didSet {
            updateConstant(constant: phone5Constant)
        }
    }
    
    fileprivate func updateConstant(constant: CGFloat) {
        let deviceModel =  UIDevice().type
        switch deviceModel {
        case  .iPhoneX, .iPhoneXS, .iPhone11Pro:
            self.constant = phoneXConstant
            layoutIfNeeded()
        case  .iPhone6, .iPhone7, .iPhone8, .iPhone6S:
            self.constant = phone6Constant
            layoutIfNeeded()
        case  .iPhone6Plus,.iPhone7Plus,.iPhone8Plus, .iPhone6SPlus:
            self.constant = pluseConstantForiPhone
            layoutIfNeeded()
        case .iPhoneXSMax, .iPhoneXR, .iPhone11, .iPhone11ProMax:
            self.constant = XsMaxConstantForiPhone
            layoutIfNeeded()
        case  .iPhone5, .iPhone5S, .iPhone5C, .iPhoneSE:
            self.constant = phone5Constant
            layoutIfNeeded()
        default:
            break
        }
    }
    
    open func layoutIfNeeded() {
        firstItem?.layoutIfNeeded()
        secondItem?.layoutIfNeeded()
    }
}
