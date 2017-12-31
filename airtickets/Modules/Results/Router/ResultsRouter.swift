//
//  ResultsRouter.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 31/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import UIKit

class ResultsRouter {
    
    // MARK: Properties
    
    weak var view: UITableViewController?
    
    // MARK: Static methods
    
    static func setupModule(_ flights: [Flight]) -> ResultsViewController {
        let viewController = UIStoryboard.loadViewController() as ResultsViewController
        
        let presenter = ResultsPresenter()
        let router = ResultsRouter()
        let interactor = ResultsInteractor()
        
        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.flights = flights
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
    
}

extension ResultsRouter: ResultsWireframe {
    
}
