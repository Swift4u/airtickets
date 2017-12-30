//
//  BaseTableContract.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import Foundation

protocol BaseTableView: class {
    func showLoading()
    func hideLoading()
    func showError(_ message: String?)
    func showMessage(_ message: String?, withTitle title: String?)
}
