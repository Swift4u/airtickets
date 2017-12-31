//
//  BookButton.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 31/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class BookButton: UIButton {
    
    // MARK:- Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    // MARK:- Private Methods
    
    fileprivate func setup() {
        setBackgroundImage(ImageHelper.imageFromColor(UIColor.topaz, forSize: self.bounds.size, withCornerRadius: 0.0), for: .normal)
        setBackgroundImage(ImageHelper.imageFromColor(UIColor.blueGreen, forSize: self.bounds.size, withCornerRadius: 0.0), for: .highlighted)
        
        layer.cornerRadius = 2.0
        layer.masksToBounds = false
        
        clipsToBounds = true
        
        titleLabel?.font = UIFont(name: Constants.Font.MontserratBold, size: 14.0)
        
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .highlighted)
    }
    
}

