//
//  AirportFilterViewController.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class AirportFilterViewController: BaseTableViewController, StoryboardLoadable, UISearchBarDelegate {
    
    // MARK: Properties
    
    var presenter: AirportFilterPresentation?
    var mainSearchRouter: MainSearchRouter?
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 20.0))
    
    var airports: [Airport] = []
    var results: [Airport] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    // MARK: Private methods
    
    fileprivate func setupView() {
        // Table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        // Search bar
        searchBar.placeholder = "SEARCH"
        searchBar.showsCancelButton = true
        searchBar.autocapitalizationType = .none
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        navigationItem.titleView = searchBar
    }
    
    // MARK: Search bar delegate
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        results.removeAll()
        
        if searchText.count > 2 {
            let search = searchText.lowercased()
            
            results = airports.filter({ (airport) -> Bool in
                if let iata = airport.iata?.lowercased(), let name = airport.name?.lowercased(), let city = airport.city?.lowercased() {
                    if iata.contains(search) || name.contains(search) || city.contains(search) {
                        return true
                    }
                }
                
                return false
            })
        }
        
        tableView.reloadData()
    }
    
    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") else {
            return UITableViewCell()
        }

        let airport = results[indexPath.row]
        
        if let iata = airport.iata, let name = airport.name, let city = airport.city {
            let fullTitle = "\(iata) - \(name), \(city)"
            let rangeIATA = (fullTitle as NSString).range(of: iata)
            let attributedText = NSMutableAttributedString(string: fullTitle)
            
            attributedText.setAttributes([NSAttributedStringKey.font : UIFont.MontserratRegular(withSize: 16.0)!, NSAttributedStringKey.foregroundColor : UIColor.darkGray], range: NSRange(location: 0, length: fullTitle.count))
            
            attributedText.beginEditing()
            attributedText.setAttributes([NSAttributedStringKey.foregroundColor : UIColor.blueGreen], range: rangeIATA)
            attributedText.endEditing()
            
            cell.textLabel?.attributedText = attributedText
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let airport = results[indexPath.row]
        presenter?.didClickAirport(airport)
        searchBar.resignFirstResponder()
        navigationController?.dismiss(animated: true, completion: nil)
    }

}

extension AirportFilterViewController: AirportFilterView {
    
    func showAirportsData(_ airports: [Airport]) {
        self.airports = airports
    }
    
}
