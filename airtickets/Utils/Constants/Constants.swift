//
//  Constants.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    
    enum URL {
        static let baseURL = "http://developer.goibibo.com/api/"
        static let flightSearch = baseURL + "search/"
    }
    
    enum ApiKeys {
        static let appId = "97d87008"
        static let appKey = "74efa4b28d88dee97752a48c5ba8892e"
    }
    
    enum Storyboard {
        static let mainSearchStoryboard = "MainSearchStoryboard"
    }
    
    enum ViewControllerIdentifier {
        static let mainSearchViewControllerIdentifier = "MainSearchViewControllerID"
    }
    
    enum Label {
        static let padding = CGFloat(10)
        static let edgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    }
    
    enum Font {
        static let MontserratRegular = "Montserrat-Regular"
        static let MontserratBold = "Montserrat-Bold"
        static let MontserratMedium = "Montserrat-Medium"
    }
    
}
