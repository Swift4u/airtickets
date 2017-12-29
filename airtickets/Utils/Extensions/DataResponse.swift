//
//  DataResponse.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import Alamofire

extension DataResponse {
    
    var isSuccess: Bool {
        get {
            guard let statusCode = response?.statusCode else { return false }
            
            if 200 ... 299 ~= statusCode {
                return true
            } else {
                return false
            }
        }
    }

}
