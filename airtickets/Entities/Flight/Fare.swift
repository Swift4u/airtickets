//
//  Fare.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import ObjectMapper

class Fare: Mappable {
    
    var totalFare: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        totalFare <- map["totalfare"]
    }
    
}
