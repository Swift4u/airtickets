//
//  ResultsViewController.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 31/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class ResultsViewController: BaseTableViewController, StoryboardLoadable {
    
    // MARK: Properties
    
    var presenter: ResultsPresentation?
    var flights: [Flight] = []
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBarAnimated(true)
    }
    
    // MARK: Private methods
    
    fileprivate func setupView() {
        // Title
        title = "PESQUISAR_PASSAGEM"
        
        // Table view
        tableView.register(UINib(nibName: "FlightTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.paleGrey
    }

    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? FlightTableViewCell else {
            return UITableViewCell()
        }
        
        let flight = flights[indexPath.row]
        
        cell.setupGo(flight)
        
        if let returnFlight = flight.returnFlights, let first = returnFlight.first {
            cell.setupBack(first)
        }
        
        if let fare = flight.fare {
            cell.setFare(fare)
        }

        return cell
    }

}

extension ResultsViewController: ResultsView {
    
    func showResults(forFlights flights: [Flight]) {
        self.flights = flights
    }

}
