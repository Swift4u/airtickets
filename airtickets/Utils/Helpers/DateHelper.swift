//
//  DateHelper.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

struct DateHelper {
    
    static func stringFromDate(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        return dateFormatter.string(from: date)
    }
    
    static func dateFromString(_ string: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        guard let date = dateFormatter.date(from: string) else { return nil }
        
        return date
    }
    
}
