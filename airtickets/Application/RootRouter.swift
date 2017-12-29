//
//  RootRouter.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class RootRouter: NSObject {
    
    func presentFirstScreen(inWindow window: UIWindow) {
        presentMainSearchScreen()
    }
    
    private func presentMainSearchScreen() {
        let mainSearchViewController = MainSearchRouter.setupModule()
        let navigationController = UINavigationController(rootViewController: mainSearchViewController)
        presentView(navigationController)
    }
    
    private func presentView(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.delegate?.window! else { return }
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        window.rootViewController = viewController
    }

}
