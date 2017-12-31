//
//  MainSearchPresenter.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import ObjectMapper

class MainSearchPresenter {
    
    // MARK: Properties
    
    weak var view: MainSearchView?
    var router: MainSearchWireframe?
    var interactor: MainSearchUseCase?
    
}

extension MainSearchPresenter: MainSearchPresentation {
    
    func didClickSearchButton(origin: Airport, destination: Airport, departure: Date, arrival: Date?, adults: String) {
        view?.showLoading()
        
        let request = FlightRequest()
        
        request.origin = origin.iata
        request.destination = destination.iata
        request.departure = departure
        request.arrival = arrival
        request.adults = adults
        
        interactor?.searchFlights(request)
    }
    
    func didClickAirportFilter() {
        router?.presentAirportFilter()
    }
    
}

extension MainSearchPresenter: MainSearchInteractorOutput {
    
    func onSearchFlightsSuccess(flights: [Flight]) {
        view?.hideLoading()
        
        if flights.count == 0 {
            view?.showError("NO_RESULTS_FOUND")
        } else {
            let results = flights.filter({ (flight) -> Bool in
                return flight.returnFlights?.first != nil
            })
            
            router?.presentResults(results)
        }
    }
    
    func onSearchFlightsFailure(message: String?) {
        if let message = message {
            view?.showError(message)
        }
        
        view?.hideLoading()
    }
    
    //TODO: Implement other methods from interactor->presenter here
    
}
