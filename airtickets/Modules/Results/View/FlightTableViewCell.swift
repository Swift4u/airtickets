//
//  FlightTableViewCell.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 31/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit
import Localize_Swift

class FlightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var btnBook: UIButton!
    
    // Departure
    @IBOutlet weak var departureView: UIView!
    @IBOutlet weak var lbDateGo: UILabel!
    @IBOutlet weak var lbAirlineGo: UILabel!
    @IBOutlet weak var lbFlightNoGo: UILabel!
    @IBOutlet weak var lbTimeDepartureGo: UILabel!
    @IBOutlet weak var lbOriginGo: UILabel!
    @IBOutlet weak var lbTimeArrivalGo: UILabel!
    @IBOutlet weak var lbDestinationGo: UILabel!
    @IBOutlet weak var lbDurationGo: UILabel!
    @IBOutlet weak var lbStopsGo: UILabel!
    @IBOutlet weak var imgArrowGo: UIImageView!

    // Arrival
    @IBOutlet weak var arrivalView: UIView!
    @IBOutlet weak var lbDateBack: UILabel!
    @IBOutlet weak var lbAirlineBack: UILabel!
    @IBOutlet weak var lbFlightNoBack: UILabel!
    @IBOutlet weak var lbTimeDepartureBack: UILabel!
    @IBOutlet weak var lbOriginBack: UILabel!
    @IBOutlet weak var lbTimeArrivalBack: UILabel!
    @IBOutlet weak var lbDestinationBack: UILabel!
    @IBOutlet weak var lbDurationBack: UILabel!
    @IBOutlet weak var lbStopsBack: UILabel!
    @IBOutlet weak var imgArrowBack: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.paleGrey
        
        innerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        innerView.layer.shadowColor = UIColor.black.cgColor
        innerView.layer.shadowOpacity = 0.1
        innerView.layer.shadowRadius = 1.0
        innerView.layer.masksToBounds = false
        
        departureView.borders(for: [.bottom], width: 1.0, color: UIColor(white: 225/255.0, alpha: 0.8))
        arrivalView.borders(for: [.bottom], width: 1.0, color: UIColor(white: 225/255.0, alpha: 0.8))
        
        imgArrowBack.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
    }
    
    func setupGo(_ flight: Flight) {
        if let airline = flight.airline {
            lbAirlineGo.text = airline.firstName().uppercased()
        }
        
        if let carrie = flight.carrierId, let flightNo = flight.flightNo {
            lbFlightNoGo.text = "\(carrie)-\(flightNo)"
        }
        
        if let departure = flight.departureTime {
            lbTimeDepartureGo.text = DateHelper.stringFromDate(departure, format: "HH:mm")
            lbDateGo.text = DateHelper.stringFromDate(departure, format: "EEEE, dd 'de' MMMM").replacingOccurrences(of: "-feira", with: "")
        }
        
        lbOriginGo.text = flight.origin
        
        lbDurationGo.text = flight.duration?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "m", with: "").uppercased()
        
        if let stops = flight.stops {
            switch stops {
            case "0": lbStopsGo.text = "VOO_DIRETO".localized()
            case "1": lbStopsGo.text = "1_PARADA".localized()
            default: lbStopsGo.text = String(format: "%@ %@", stops, "PARADAS".localized())
            }
        }
        
        if let arrival = flight.arrivalTime {
            lbTimeArrivalGo.text = DateHelper.stringFromDate(arrival, format: "HH:mm")
        }
        
        lbDestinationGo.text = flight.destination
    }
    
    func setupBack(_ flight: Flight) {
        if let airline = flight.airline {
            lbAirlineBack.text = airline.firstName().uppercased()
        }
        
        if let carrie = flight.carrierId, let flightNo = flight.flightNo {
            lbFlightNoBack.text = "\(carrie)-\(flightNo)"
        }
        
        if let departure = flight.departureTime {
            lbTimeDepartureBack.text = DateHelper.stringFromDate(departure, format: "HH:mm")
            lbDateBack.text = DateHelper.stringFromDate(departure, format: "EEEE, dd 'de' MMMM").replacingOccurrences(of: "-feira", with: "")
        }
        
        lbOriginBack.text = flight.origin
        
        lbDurationBack.text = flight.duration?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "m", with: "").uppercased()
        
        if let stops = flight.stops {
            switch stops {
            case "0": lbStopsBack.text = "VOO_DIRETO".localized()
            case "1": lbStopsBack.text = "1_PARADA".localized()
            default: lbStopsBack.text = String(format: "%@ %@", stops, "PARADAS".localized())
            }
        }
        
        if let arrival = flight.arrivalTime {
            lbTimeArrivalBack.text = DateHelper.stringFromDate(arrival, format: "HH:mm")
        }
        
        lbDestinationBack.text = flight.destination
    }
    
    func setFare(_ fare: Fare) {
        guard let totalFare = fare.totalFare else { return }
        let strBook = String(format: "%@ %@", "COMPRAR".localized(), NumberHelper.doubleToCurrency(totalFare))
        btnBook.setTitle(strBook, for: .normal)
    }
    
}
