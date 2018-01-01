//
//  SearchButton.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class SearchButton: UIButton {

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
        
        layer.cornerRadius = 4.0
        layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        layer.shadowColor = UIColor.blueGreen.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 1.0
        layer.masksToBounds = false
        
        clipsToBounds = true
        
        let icSearch = UIImage(named: "btnUnselectedBranco")
        
        titleLabel?.font = UIFont(name: Constants.Font.MontserratBold, size: 14.0)

        setImage(icSearch, for: .normal)
        setImage(icSearch, for: .highlighted)
        
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .highlighted)
        
        imageEdgeInsets = UIEdgeInsetsMake(0.0, -5.0, 0.0, 5.0)
        titleEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0.0, -5.0)
    }

}
