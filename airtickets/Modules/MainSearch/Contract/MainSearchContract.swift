//
//  MainSearchContract.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

protocol MainSearchView: BaseView {
    func onAirportSelected(_ airport: Airport)
}

protocol MainSearchPresentation: class {
    func didClickSearchButton(origin: Airport, destination: Airport, departure: Date, arrival: Date, adults: String)
    func didClickAirportFilter()
}

protocol MainSearchUseCase: class {
    func searchFlights(_ request: FlightRequest)
}

protocol MainSearchInteractorOutput: class {
    func onSearchFlightsSuccess(flights: [Flight])
    func onSearchFlightsFailure(message: String?)
}

protocol MainSearchWireframe: class {
    func presentAirportFilter()
    func onAirportSelected(_ airport: Airport)
}
