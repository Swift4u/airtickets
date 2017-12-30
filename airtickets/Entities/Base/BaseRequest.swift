//
//  BaseRequest.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseRequest: Mappable {
    
    var appId: String?
    var appKey: String?
    
    init() {
        appId = Constants.ApiKeys.appId
        appKey = Constants.ApiKeys.appKey
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        appId <- map["app_id"]
        appKey <- map["app_key"]
    }
    
}
