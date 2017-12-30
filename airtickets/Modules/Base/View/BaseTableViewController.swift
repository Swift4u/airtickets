//
//  BaseTableViewController.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController, BaseTableView {
    
    // MARK: Methods
    
    func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        LoadingSpinner.show("LOADING")
    }
    
    func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        LoadingSpinner.hide()
    }
    
    func showMessage(_ message: String?, withTitle title: String?) {
        let errorMessage = message ?? "GENERIC_ERROR_MESSAGE"
        let errorTitle = title ?? "ERROR"
        let errorController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(errorController, animated: true, completion: nil)
    }
    
    func showError(_ message: String?) {
        let errorMessage = message ?? "GENERIC_ERROR_MESSAGE"
        let errorController = UIAlertController(title: "TITLE_ERROR", message: errorMessage, preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(errorController, animated: true, completion: nil)
    }
    
}

