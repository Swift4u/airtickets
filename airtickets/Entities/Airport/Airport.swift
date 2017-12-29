//
//  Airport.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import ObjectMapper

class Airport: Mappable {
    
    var iata: String?
    var name: String?
    var city: String?
    var country: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        iata <- map["iata"]
        name <- map["name"]
        city <- map["city"]
        country <- map["country"]
    }
    
}
