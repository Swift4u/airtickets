//
//  AirportFilterContract.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

protocol AirportFilterView: BaseTableView {
    weak var mainSearchRouter: MainSearchRouter? { get set }
    func showAirportsData(_ airports: [Airport])
}

protocol AirportFilterPresentation: class {
    func viewDidLoad()
    func didClickAirport(_ airport: Airport)
}

protocol AirportFilterUseCase: class {
    func listAirports()
}

protocol AirportFilterInteractorOutput: class {
    func onListAirportsSuccess(airports: [Airport])
    func onListAirportsFailure(message: String?)
}

protocol AirportFilterWireframe: class {

}
