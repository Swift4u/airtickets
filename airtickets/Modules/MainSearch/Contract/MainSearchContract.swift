//
//  MainSearchContract.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

protocol MainSearchView: BaseView {
    
}

protocol MainSearchPresentation: class {
    func didClickSearchButton()
}

protocol MainSearchUseCase: class {
    func searchFlights()
}

protocol MainSearchInteractorOutput: class {
    func onSearchFlightsSuccess(flights: [Flight])
    func onSearchFlightsFailure(message: String?)
}

protocol MainSearchWireframe: class {
    
}
