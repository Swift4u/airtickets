//
//  ResultsPresenter.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 31/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

class ResultsPresenter {
    
    // MARK: Properties
    
    weak var view: ResultsView?
    var router: ResultsWireframe?
    var interactor: ResultsUseCase?
    var original: [Flight]!
    var flights: [Flight]!
    var lastSort: ComparisonResult?
    
}

extension ResultsPresenter: ResultsPresentation {
    
    func viewDidLoad() {
        view?.showResults(forFlights: original)
    }
    
    func sortFare(by order: ComparisonResult) {
        lastSort = order
        
        flights = flights.sorted { (a, b) -> Bool in
            guard let fareA = a.fare?.totalFare, let fareB = b.fare?.totalFare else { return false }
            return order == .orderedAscending ? (fareA < fareB) : (fareA > fareB)
        }
        
        view?.showResults(forFlights: flights)
    }
    
    func filterAirline(_ name: String) {
        if name == "" {
            flights = original
            
            if let order = lastSort {
                flights = original.sorted { (a, b) -> Bool in
                    guard let fareA = a.fare?.totalFare, let fareB = b.fare?.totalFare else { return false }
                    return order == .orderedAscending ? (fareA < fareB) : (fareA > fareB)
                }
            }
            
            view?.showResults(forFlights: flights)
        } else {
            flights = original.filter { (flight) -> Bool in
                guard let airline = flight.airline else { return false }
                return airline == name
            }
            
            view?.showResults(forFlights: flights)
        }
    }
    
}

extension ResultsPresenter: ResultsInteractorOutput {
    
}
