//
//  UIImage+Icons.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit
import FontAwesome_swift

extension UIImage {
    
    static var backIcon: UIImage {
        return UIImage.fontAwesomeIcon(name: .arrowLeft, textColor: .white, size: CGSize(width: 30.0, height: 30.0))
    }
    
}
