//
//  Dictionary.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

extension Dictionary {
    
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }

}
