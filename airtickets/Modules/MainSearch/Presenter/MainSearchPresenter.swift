//
//  MainSearchPresenter.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

class MainSearchPresenter {
    
    // MARK: Properties
    
    weak var view: MainSearchView?
    var router: MainSearchWireframe?
    var interactor: MainSearchUseCase?
    
}

extension MainSearchPresenter: MainSearchPresentation {
    
    func didClickSearchButton() {
        //interactor?.searchFlights()
        view?.showLoading()
    }
    
    //TODO: Implement other methods from presenter->view here
    
}

extension MainSearchPresenter: MainSearchInteractorOutput {
    
    func onSearchFlightsSuccess(flights: [Flight]) {
        view?.hideLoading()
    }
    
    func onSearchFlightsFailure(message: String?) {
        if let message = message {
            view?.showError(message)
        }
        
        view?.hideLoading()
    }
    
    //TODO: Implement other methods from interactor->presenter here
    
}
