//
//  ResultSearch.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import ObjectMapper

class ResultSearch: Mappable {
    
    var data: ListFlight?
    var lenght: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        lenght <- map["lenght"]
    }
    
}

class ListFlight: Mappable {
    
    var returnFlights: [Flight]?
    var onwardFlights: [Flight]?
    var error: ResponseErrors?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        returnFlights <- map["returnflights"]
        onwardFlights <- map["onwardflights"]
        error <- map["Error"]
    }
    
}
