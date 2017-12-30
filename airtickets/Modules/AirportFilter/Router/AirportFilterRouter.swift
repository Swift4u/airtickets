//
//  AirportFilterRouter.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import UIKit

class AirportFilterRouter {
    
    // MARK: Properties
    
    weak var view: UITableViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> AirportFilterViewController {
        let viewController = UIStoryboard.loadViewController() as AirportFilterViewController
        
        let presenter = AirportFilterPresenter()
        let router = AirportFilterRouter()
        let interactor = AirportFilterInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
    
}

extension AirportFilterRouter: AirportFilterWireframe {
    
}
