//
//  UIFont+Utils.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func TrebuchetMS(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: Constants.Font.TrebuchetMS, size: size)
    }
    
    static func TrebuchetMSItalic(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: Constants.Font.TrebuchetMSItalic, size: size)
    }
    
    static func TrebuchetMSBold(withSize size: CGFloat) -> UIFont? {
        return UIFont(name: Constants.Font.TrebuchetMSBold, size: size)
    }
    
}
