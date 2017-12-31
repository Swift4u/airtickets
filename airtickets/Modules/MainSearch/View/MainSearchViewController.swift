//
//  MainSearchViewController.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class MainSearchViewController: BaseViewController, StoryboardLoadable, UITextFieldDelegate {
    
    // MARK: Properties
    
    var presenter: MainSearchPresentation?
    var departurePicker: TimePickerView!
    var arrivalPicker: TimePickerView!
    var origin: Airport?
    var destination: Airport?

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
        guard let origin = origin else {
            tfOrigin.isInvalidTextField = true
            showError("INVALID_ORIGIN")
            return
        }
        
        guard let destination = destination else {
            tfDestination.isInvalidTextField = true
            showError("INVALID_DESTINATION")
            return
        }
        
        if tfDeparture.text == "" {
            tfDeparture.isInvalidTextField = true
            showError("INVALID_DEPARTURE")
            return
        }

        guard let numPassengers = tfPassengers.text, numPassengers != "" else {
            tfPassengers.isInvalidTextField = true
            showError("INVALID_PASSENGERS")
            return
        }
        
        presenter?.didClickSearchButton(origin: origin, destination: destination, departure: departurePicker.pickerView.date, arrival: (tfArrival.text != "" ? arrivalPicker.pickerView.date : nil), adults: numPassengers)
    }
    
    // MARK: Private
    
    private func setupView() {
        view.backgroundColor = UIColor.paleGrey
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        tfOrigin.setRightIcon(UIImage(named: "pin"))
        tfDestination.setRightIcon(UIImage(named: "pin"))
        tfDeparture.setRightIcon(UIImage(named: "calendario"))
        tfArrival.setRightIcon(UIImage(named: "calendario"))
        tfPassengers.setRightIcon(UIImage(named: "passageiros"))
        
        setupDepartureArrival()
        setupPassengers()
    }
    
    fileprivate func setupDepartureArrival() {
        // Departure
        departurePicker = TimePickerView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: 258.0))
        
        departurePicker.btnDone.action = #selector(doneTimePickerClicked(_:))
        departurePicker.btnCancel.action = #selector(cancelTimePickerClicked(_:))
        departurePicker.pickerView.minimumDate = Date()
        
        tfDeparture.inputView = departurePicker
        
        // Arrival
        arrivalPicker = TimePickerView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: 258.0))
        
        arrivalPicker.btnDone.action = #selector(doneTimePickerClicked(_:))
        arrivalPicker.btnCancel.action = #selector(cancelTimePickerClicked(_:))
        
        tfArrival.inputView = arrivalPicker
    }
    
    fileprivate func setupPassengers() {
        let options = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        tfPassengers.inputView = ListPickerView(tfPassengers, list: options, current: options.first)
    }
    
    // MARK: Timepicker actions
    
    @objc func doneTimePickerClicked(_ sender: UIBarButtonItem?) {
        if activeField == tfDeparture {
            tfDeparture.text = DateHelper.stringFromDate(departurePicker.pickerView.date, format: "dd/MM/yyyy")
            arrivalPicker.pickerView.minimumDate = departurePicker.pickerView.date
            
            tfArrival.isEnabled = true
            
            if departurePicker.pickerView.date.compare(arrivalPicker.pickerView.date) != .orderedAscending {
                tfArrival.text = ""
            }
        } else {
            tfArrival.text = DateHelper.stringFromDate(arrivalPicker.pickerView.date, format: "dd/MM/yyyy")
        }
        
        if let activeField = activeField {
            activeField.resignFirstResponder()
        }
    }
    
    @objc func cancelTimePickerClicked(_ sender: UIBarButtonItem?) {
        if let activeField = activeField {
            activeField.resignFirstResponder()
        }
    }
    
    // MARK: Textfield delegates
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        
        if textField == tfOrigin || textField == tfDestination {
            presenter?.didClickAirportFilter()
            return false
        }
        
        return true
    }
    
}

extension MainSearchViewController: MainSearchView {
    
    func onAirportSelected(_ airport: Airport) {
        var airportText: String = ""
        
        if let iata = airport.iata, let name = airport.name, let city = airport.city {
            airportText = "\(iata) - \(name), \(city)"
        }
        
        activeField?.text = airportText

        if activeField == tfOrigin {
            origin = airport
        } else {
            destination = airport
        }
        
        activeField = nil
    }
    
}
