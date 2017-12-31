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
    var filtered: Bool = false
    
    var flights: [Flight] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var airlines: [String] = []
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
        
        for flight: Flight in flights {
            if let airline = flight.airline {
                if airlines.contains(airline) == false {
                    airlines.append(airline)
                }
            }
        }
        
        airlines.sort()
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 39.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ResultsHeaderView", owner: self, options: nil)![0] as? UIView else {
            return UIView()
        }
        
        headerView.backgroundColor = UIColor.coolGrey
        headerView.alpha = 0.9
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = ResultsFooterView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: 40.0))
        
        footerView.btnFilter.addTarget(self, action: #selector(didClickFilter(_:)), for: .touchUpInside)
        footerView.btnSort.addTarget(self, action: #selector(didClickSort(_:)), for: .touchUpInside)
        
        return footerView
    }
    
    // MARK: Actions
    
    @objc func didClickFilter(_ sender: UIButton) {
        var actions: [UIAlertAction] = []
        
        for name: String in airlines {
            let filterAction = UIAlertAction(title: name.firstName().uppercased(), style: .default) { (action) in
                self.filtered = true
                self.presenter?.filterAirline(name)
            }
            
            actions.append(filterAction)
        }
        
        if filtered {
            let filterActionAll = UIAlertAction(title: "REMOVE_FILTER", style: .destructive) { (action) in
                self.filtered = false
                self.presenter?.filterAirline("")
            }
            
            actions.append(filterActionAll)
        }
        
        actions.append(UIAlertAction(title: "CANCELAR", style: .cancel, handler: nil))
        
        UIAlertController.presentActionSheetInViewController(self, title: "FILTRAR_AIRLINE", message: nil, actions: actions, completion: nil)
    }
    
    @objc func didClickSort(_ sender: UIButton) {
        let fareDesc = UIAlertAction(title: "MAIOR_VALOR", style: .default) { (action) in
            self.presenter?.sortFare(by: .orderedDescending)
        }
        
        let fareAsc = UIAlertAction(title: "MENOR_VALOR", style: .default) { (action) in
            self.presenter?.sortFare(by: .orderedAscending)
        }
        
        let cancel = UIAlertAction(title: "CANCELAR", style: .cancel, handler: nil)
        
        let actions: [UIAlertAction] = [fareDesc, fareAsc, cancel]
        
        UIAlertController.presentActionSheetInViewController(self, title: "ORDENAR", message: nil, actions: actions, completion: nil)
    }

}

extension ResultsViewController: ResultsView {
    
    func showResults(forFlights flights: [Flight]) {
        self.flights = flights
    }
    
}
