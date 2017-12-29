//
//  MainSearchRouter.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation
import UIKit

class MainSearchRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> MainSearchViewController {
        let viewController = UIStoryboard.loadViewController() as MainSearchViewController
        
        let presenter = MainSearchPresenter()
        let router = MainSearchRouter()
        let interactor = MainSearchInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }

}

extension MainSearchRouter: MainSearchWireframe {
    // TODO: Implement wireframe methods
}
