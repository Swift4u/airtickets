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
    
    func searchFlights(_ params: FlightRequest, completion: @escaping (_ response: [Flight]?, _ error: Error?) -> Void) {
        let url = Constants.URL.flightSearch
        
        Alamofire
            .request(url, method: .get, parameters: params.toJSON(), encoding: URLEncoding.default, headers: nil)
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
