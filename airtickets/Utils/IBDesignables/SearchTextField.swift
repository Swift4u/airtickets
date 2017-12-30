//
//  SearchTextField.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {
    let animationDuration = 0.3
    var hintYPadding: CGFloat = 0.0
    var title = UILabel()
    
    override var placeholder: String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()
        }
    }
    
    override var attributedPlaceholder: NSAttributedString? {
        didSet {
            title.text = attributedPlaceholder?.string
            title.sizeToFit()
        }
    }
    
    var titleFont: UIFont = UIFont(name: Constants.Font.MontserratRegular, size: 10.0)! {
        didSet {
            title.font = titleFont
            title.sizeToFit()
        }
    }
    
    var titleYPadding: CGFloat = 13.0 {
        didSet {
            var r = title.frame
            r.origin.y = titleYPadding
            title.frame = r
        }
    }
    
    var titleTextColour: UIColor = UIColor.coolGrey {
        didSet {
            if !isFirstResponder {
                title.textColor = titleTextColour
            }
        }
    }
    
    var titleActiveTextColour: UIColor! {
        didSet {
            if isFirstResponder {
                title.textColor = titleActiveTextColour
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = UIColor.white
            } else {
                backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 0.7)
            }
        }
    }
    
    // MARK:- Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    // MARK:- Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
        if let txt = text, !txt.isEmpty && isResp {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleTextColour
        }
        // Should we show or hide the title label?
        if let txt = text, txt.isEmpty {
            // Hide
            hideTitle(isResp)
        } else {
            // Show
            showTitle(isResp)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.textRect(forBounds: bounds)
        
        if let txt = text, !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(top, 10.0, 0.0, -10.0))
        } else {
            return CGRect(x: bounds.origin.x + Constants.Label.padding, y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }
        
        return r.integral
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.textRect(forBounds: bounds)
        
        if let txt = text, !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(top, 10.0, 0.0, -10.0))
        } else {
            return CGRect(x: bounds.origin.x + Constants.Label.padding, y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }
        
        return r.integral
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + Constants.Label.padding, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    fileprivate func maxTopInset() -> CGFloat {
        if let fnt = font {
            return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
        }
        return 0
    }

    fileprivate func setup() {
        titleActiveTextColour = UIColor.topaz
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        
        if let str = placeholder, !str.isEmpty {
            title.text = str
            title.sizeToFit()
        }
        
        self.addSubview(title)
        
        font = UIFont(name: Constants.Font.MontserratRegular, size: 14.0)
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.silver.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 1.0
        layer.masksToBounds = false
        
        if isEnabled {
            backgroundColor = UIColor.white
        } else {
            backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 0.7)
        }
    }
    
    func setRightIcon(_ rightIcon: UIImage?) {
        let dropView: UIImageView = UIImageView(image: rightIcon)
        dropView.frame = CGRect(x: 0.0, y: (frame.height / 2), width: 35.0, height: 19.0)
        dropView.contentMode = .scaleAspectFit
        
        rightViewMode = UITextFieldViewMode.always
        rightView = dropView
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return rightView != nil ? CGRect.zero : super.caretRect(for: position)
    }
    
    fileprivate func setTitlePositionForTextAlignment() {
        let r = textRect(forBounds: bounds)
        var x = r.origin.x
        if textAlignment == NSTextAlignment.center {
            x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == NSTextAlignment.right {
            x = r.origin.x + r.size.width - title.frame.size.width
        }
        title.frame = CGRect(x:x, y:title.frame.origin.y, width:title.frame.size.width, height:title.frame.size.height)
    }
    
    fileprivate func showTitle(_ animated: Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.curveEaseOut], animations:{
            // Animation
            self.title.alpha = 1.0
            var r = self.title.frame
            r.origin.y = self.titleYPadding
            self.title.frame = r
        }, completion:nil)
    }
    
    fileprivate func hideTitle(_ animated: Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.curveEaseIn], animations:{
            // Animation
            self.title.alpha = 0.0
            var r = self.title.frame
            r.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = r
        }, completion: nil)
    }
}
