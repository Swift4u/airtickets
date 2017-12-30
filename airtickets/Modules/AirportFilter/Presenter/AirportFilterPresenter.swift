//
//  AirportFilterPresenter.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

class AirportFilterPresenter {
    
    // MARK: Properties
    
    weak var view: AirportFilterView?
    var router: AirportFilterWireframe?
    var interactor: AirportFilterUseCase?

    var listAirports: [Airport] = [] {
        didSet {
            view?.showAirportsData(listAirports)
        }
    }

}

extension AirportFilterPresenter: AirportFilterPresentation {
    
    func viewDidLoad() {
        interactor?.listAirports()
    }
    
    func didClickAirport(_ airport: Airport) {
        view?.mainSearchRouter?.onAirportSelected(airport)
    }
    
}

extension AirportFilterPresenter: AirportFilterInteractorOutput {
    
    func onListAirportsSuccess(airports: [Airport]) {
        listAirports = airports
    }
    
    func onListAirportsFailure(message: String?) {
        if let message = message {
            view?.showError(message)
        }
    }
    
}
