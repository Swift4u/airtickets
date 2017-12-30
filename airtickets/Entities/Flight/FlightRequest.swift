//
//  FlightRequest.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import ObjectMapper

class FlightRequest: BaseRequest {
    
    var origin: String?
    var destination: String?
    var departure: Date?
    var arrival: Date?
    var seatingClass: String = "E"
    var adults: String?
    var children: String = "0"
    var infants: String = "0"
    var counter: String = "100"
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        origin <- map["source"]
        destination <- map["destination"]
        departure <- (map["dateofdeparture"], dateTransform)
        arrival <- (map["dateofarrival"], dateTransform)
        seatingClass <- map["seatingclass"]
        adults <- map["adults"]
        children <- map["children"]
        infants <- map["infants"]
        counter <- map["counter"]
    }
    
    let dateTransform = TransformOf<Date, String>(fromJSON: { (value: String?) -> Date? in
        if let value = value {
            return DateHelper.dateFromString(value, format: "yyyyMMdd")
        }
        return nil
    }, toJSON: { (value: Date?) -> String? in
        if let value = value {
            return DateHelper.stringFromDate(value, format: "yyyyMMdd")
        }
        return nil
    })
    
}
