//
//  UIFont+Utils.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func MontserratRegular(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: Constants.Font.MontserratRegular, size: size)
    }
    
    static func MontserratBold(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: Constants.Font.MontserratBold, size: size)
    }
    
    static func MontserratMedium(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: Constants.Font.MontserratMedium, size: size)
    }
    
}
