//
//  FlightApiDataManager.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class FlightApiDataManager: NSObject {
    
    func searchFlights(completion: @escaping (_ response: [Flight]?, _ error: Error?) -> Void) {
        let url = Constants.URL.flightSearch
        
        let params: [String : Any] = ["app_id": Constants.ApiKeys.appId, "app_key": Constants.ApiKeys.appKey, "source": "CNF", "destination": "GRU", "dateofdeparture": "20180126", "dateofarrival": "20180207", "adults": 2, "seatingclass": "E", "children": 0, "infants": 0, "counter": 100]
        
        Alamofire
            .request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .responseObject(completionHandler: { (response: DataResponse<ResultSearch>) in
                if let err = response.result.value?.data?.error {
                    let objError = NSError(domain: "api", code: 200, userInfo: [NSLocalizedDescriptionKey : err.error ?? ""])
                    completion(nil, objError)
                } else {
                    completion(response.result.value?.data?.onwardFlights, response.error)
                }
            })
    }

}
