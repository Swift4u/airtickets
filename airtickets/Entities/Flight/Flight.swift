//
//  Flight.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import ObjectMapper

class Flight: Mappable {
    
    var flightNo: String?
    var origin: String?
    var destination: String?
    var departureTime: Date?
    var arrivalTime: Date?
    var duration: String?
    var stops: String?
    var carrierId: String?
    var airline: String?
    var fare: Fare?
    var returnFlights: [Flight]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        flightNo <- map["flightno"]
        origin <- map["origin"]
        destination <- map["destination"]
        departureTime <- (map["DepartureTime"], dateTransform)
        arrivalTime <- (map["ArrivalTime"], dateTransform)
        duration <- map["duration"]
        stops <- map["stops"]
        carrierId <- map["carrierid"]
        airline <- map["airline"]
        fare <- map["fare"]
        returnFlights <- map["returnfl"]
    }
    
    let dateTransform = TransformOf<Date, String>(fromJSON: { (value: String?) -> Date? in
        if let value = value {
            return DateHelper.dateFromString(value, format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        }
        return nil
    }, toJSON: { (value: Date?) -> String? in
        if let value = value {
            return DateHelper.stringFromDate(value, format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        }
        return nil
    })

}
