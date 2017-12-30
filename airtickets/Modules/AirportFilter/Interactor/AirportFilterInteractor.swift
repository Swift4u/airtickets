//
//  AirportFilterInteractor.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

class AirportFilterInteractor {
    
    // MARK: Properties
    
    weak var output: AirportFilterInteractorOutput?
    
    var localDataManager = AirportLocalDataManager()
    
}

extension AirportFilterInteractor: AirportFilterUseCase {
    
    func listAirports() {
        localDataManager.listAirports { (response, error) in
            if let response = response {
                self.output?.onListAirportsSuccess(airports: response)
            } else {
                self.output?.onListAirportsFailure(message: error?.localizedDescription)
            }
        }
    }
    
}
