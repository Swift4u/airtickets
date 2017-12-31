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
    var flights: [Flight]!
    
}

extension ResultsPresenter: ResultsPresentation {
    
    func viewDidLoad() {
        view?.showResults(forFlights: flights)
    }
    
}

extension ResultsPresenter: ResultsInteractorOutput {
    
}
