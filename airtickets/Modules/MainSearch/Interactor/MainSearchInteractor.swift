//
//  MainSearchInteractor.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ReachabilitySwift
import Localize_Swift

class MainSearchInteractor {
    
    // MARK: Properties
    
    weak var output: MainSearchInteractorOutput?
    
    var apiDataManager = FlightApiDataManager()
    var localDataManager = AirportLocalDataManager()
    
}

extension MainSearchInteractor: MainSearchUseCase {
    
    func searchFlights(_ request: FlightRequest) {
        if Reachability()?.currentReachabilityStatus == .notReachable {
            output?.onSearchFlightsFailure(message: "NO_INTERNET".localized())
            return
        }
        
        apiDataManager.searchFlights(request) { (response, error) in
            if let response = response {
                self.output?.onSearchFlightsSuccess(flights: response)
            } else {
                self.output?.onSearchFlightsFailure(message: error?.localizedDescription)
            }
        }
    }

}
