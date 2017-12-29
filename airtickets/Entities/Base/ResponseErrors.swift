//
//  ResponseErrors.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseErrors: Mappable {
    
    var error: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error <- map["Error"]
    }
    
}
