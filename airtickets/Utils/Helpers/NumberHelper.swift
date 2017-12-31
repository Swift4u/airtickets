//
//  NumberHelper.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 31/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

struct NumberHelper {
    
    static func doubleToCurrency(_ value: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "pt_BR")
        currencyFormatter.currencySymbol = "R$ "
        currencyFormatter.isLenient = true
        currencyFormatter.generatesDecimalNumbers = true
        
        return currencyFormatter.string(from: value as NSNumber) ?? "\(value)"
    }
    
}
