//
//  TitleTextField.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/26/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

@IBDesignable class TitleTextField: UITextField {
    var _titleLabel = UILabel()
    let bottomLineView = UIView()
    
    // MARK:- Properties
    override var accessibilityLabel:String? {
        get {
            if let txt = text , txt.isEmpty {
                return _titleLabel.text
            }
            return text
        }
        set {
            self.accessibilityLabel = newValue
        }
    }
    
    override var placeholder:String? {
        didSet {
            _titleLabel.text = placeholder
            _titleLabel.sizeToFit()
        }
    }
    @IBInspectable var placeHolderColor: UIColor = Constants.Colors.textFieldPlaceholderColor
        {
        didSet {
            let placeHolderFont:UIFont = UIFont(name: Constants.Roboto.regular, size:(self.font?.pointSize)!)!

            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[.foregroundColor:placeHolderColor, .font:placeHolderFont])
        }
    }
    
    
    override var attributedPlaceholder:NSAttributedString? {
        didSet {
            _titleLabel.text = attributedPlaceholder?.string
            _titleLabel.sizeToFit()
        }
    }
    
    var titleFont: UIFont = UIFont(name: Constants.Roboto.regular, size: 12)! {
        didSet {
            _titleLabel.font = titleFont
            _titleLabel.sizeToFit()
        }
    }
    
    @IBInspectable var titleTextColor: UIColor = .white {
        didSet {
            _titleLabel.textColor = titleTextColor
        }
    }
    
    @IBInspectable var bottomLineColor: UIColor = .clear {
        didSet {
            bottomLineView.backgroundColor = bottomLineColor
        }
    }
    
    // MARK:- Init
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    // MARK:- Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        setViewPosition()
        let isResp = isFirstResponder
        _titleLabel.textColor = titleTextColor
        bottomLineView.backgroundColor = bottomLineColor
        // Should we show or hide the title label?
        if let txt = text , txt.isEmpty {
            // Hide
            if isResp {
                showTitleLabel()
                return
            }
            hideTitleLabel()
            return
        }
        showTitleLabel()
    }
    
    override func textRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.textRect(forBounds: bounds)
        var top = ceil(_titleLabel.font.lineHeight)
        top = min(top, maxTopInset())
        r = r.inset(by: UIEdgeInsets.init(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        return r.integral
    }
    
    override func editingRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.editingRect(forBounds: bounds)
        var top = ceil(_titleLabel.font.lineHeight)
        top = min(top, maxTopInset())
        r = r.inset(by: UIEdgeInsets.init(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        return r.integral
    }
    
    override func clearButtonRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.clearButtonRect(forBounds: bounds)
        var top = ceil(_titleLabel.font.lineHeight)
        top = min(top, maxTopInset())
        r = CGRect(x:r.origin.x, y:r.origin.y + (top * 0.5), width:r.size.width, height:r.size.height)
        return r.integral
    }
    
    // MARK:- Private Methods
    fileprivate func setup() {
        
        borderStyle = UITextField.BorderStyle.none
        // Set up title label
        _titleLabel.alpha = 0.0
        _titleLabel.font = titleFont
        _titleLabel.textColor = titleTextColor
        bottomLineView.backgroundColor = _titleLabel.textColor
        if let str = placeholder , !str.isEmpty {
            _titleLabel.text = str
            _titleLabel.sizeToFit()
        }
        addSubview(_titleLabel)
        addSubview(bottomLineView)
        layer.masksToBounds = true
    }
    
    fileprivate func maxTopInset()->CGFloat {
        if let fnt = font {
            return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
        }
        return 0
    }
    
    fileprivate func setTitlePositionForTextAlignment() {
        let r = textRect(forBounds: bounds)
        var x = r.origin.x
        if textAlignment == NSTextAlignment.center {
            x = r.origin.x + (r.size.width * 0.5) - _titleLabel.frame.size.width
        } else if textAlignment == NSTextAlignment.right {
            x = r.origin.x + r.size.width - _titleLabel.frame.size.width
        }
        _titleLabel.frame = CGRect(x:x, y:bounds.origin.y, width:_titleLabel.frame.size.width, height:_titleLabel.frame.size.height)
    }
    
    fileprivate func setViewPosition() {
        bottomLineView.frame = CGRect(x: 0, y: frame.size.height - 1, width:  frame.size.width, height: 1)
    }
    
    fileprivate func showTitleLabel() {
        self._titleLabel.alpha = 1.0
        let dur = 0.3
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut], animations:{
            // Animation
            self.placeHolderColor = UIColor.clear
            var r = self._titleLabel.frame
            r.origin.y = 0
            self._titleLabel.frame = r
        }, completion:nil)
    }
    
    fileprivate func hideTitleLabel() {
        _titleLabel.alpha = 0.0
        let dur = 0.3
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn], animations:{
            // Animation
            self.placeHolderColor = Constants.Colors.textFieldPlaceholderColor
            var r = self._titleLabel.frame
            r.origin.y = self._titleLabel.font.lineHeight
            self._titleLabel.frame = r
        }, completion:nil)
    }
    
    
//    // ru, en, ....
//    var languageCode:String?{
//        didSet{
//            if self.isFirstResponder{
//                self.resignFirstResponder();
//                self.becomeFirstResponder();
//            }
//        }
//    }
//
//    override var textInputMode: UITextInputMode?{
//        if let language_code = self.languageCode{
//            for keyboard in UITextInputMode.activeInputModes{
//                if let language = keyboard.primaryLanguage{
//                    let locale = Locale.init(identifier: language);
//                    if locale.languageCode == language_code{
//                        return keyboard;
//                    }
//                }
//            }
//        }
//        return super.textInputMode;
//    }

}
