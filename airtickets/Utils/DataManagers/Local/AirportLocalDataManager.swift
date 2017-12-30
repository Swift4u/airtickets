//
//  AirportLocalDataManager.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import ObjectMapper

class AirportLocalDataManager: NSObject {
    
    func listAirports(completion: @escaping (_ response: [Airport]?, _ error: Error?) -> Void) {
        var result: [Airport] = []

        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            if let path = Bundle.main.path(forResource: "airports", ofType: "json"), let json = try? String(contentsOfFile: path, encoding: String.Encoding.utf8), let airports = Mapper<Airport>().mapArray(JSONString: json) {
                for airport: Airport in airports {
                    if airport.iata != "" && airport.iata != "0" && airport.country == "BR" {
                        result.append(airport)
                    }
                }
            }
            
            DispatchQueue.main.async(execute: {
                if result.count > 0 {
                    completion(result, nil)
                } else {
                    let objError = NSError(domain: "local", code: 200, userInfo: [NSLocalizedDescriptionKey : "error"])
                    completion(nil, objError)
                }
            })
        })
    }

}
