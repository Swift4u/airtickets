//
//  MainSearchViewController.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class MainSearchViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    
    var presenter: MainSearchPresentation?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var tfOrigin: SearchTextField!
    @IBOutlet weak var tfDestination: SearchTextField!
    @IBOutlet weak var tfDeparture: SearchTextField!
    @IBOutlet weak var tfArrival: SearchTextField!
    @IBOutlet weak var tfPassengers: SearchTextField!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardNotifications(with: scrollView)
        hideNavigationBarAnimated(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardNotification()
    }
    
    // MARK: IBActions
    
    @IBAction func onSearchFlights(_ sender: UIButton?) {
        presenter?.didClickSearchButton()
    }
    
    // MARK: Private
    
    private func setupView() {
        view.backgroundColor = UIColor.paleGrey
        
        tfOrigin.setRightIcon(UIImage(named: "pin"))
        tfDestination.setRightIcon(UIImage(named: "pin"))
        tfDeparture.setRightIcon(UIImage(named: "calendario"))
        tfArrival.setRightIcon(UIImage(named: "calendario"))
        tfPassengers.setRightIcon(UIImage(named: "passageiros"))
    }
    
    func moveToNextField(_ view: UIView, nextFieldTag: Int) {
        let nextResponder = view.superview?.viewWithTag(nextFieldTag) as UIResponder!
        if (nextResponder != nil) {
            nextResponder?.becomeFirstResponder()
        } else {
            view.resignFirstResponder()
        }
    }
    
}

extension  MainSearchViewController: MainSearchView {
    
    //TODO: Implement MainSearchView methods here
    
}
