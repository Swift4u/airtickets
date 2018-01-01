//
//  FlightApiDataManagerTests.swift
//  airticketsTests
//
//  Created by Paulo Rodrigues on 01/01/18.
//  Copyright © 2018 MaxMilhas. All rights reserved.
//

import XCTest
@testable import airtickets

class FlightApiDataManagerTests: XCTestCase {
    
    let dataManager: FlightApiDataManager = FlightApiDataManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchFlightSuccessfully() {
        let expectation = XCTestExpectation(description: "Expect successfully request")
        
        let request = FlightRequest()
        
        request.origin = "CNF"
        request.destination = "GRU"
        request.departure = DateHelper.dateFromString("2018-01-26", format: "yyyy-MM-dd")
        request.arrival = DateHelper.dateFromString("2018-02-07", format: "yyyy-MM-dd")
        request.adults = "2"
        
        dataManager.searchFlights(request) { (response, error) in
            XCTAssertNotNil(response, "Should return an array")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSearchFlightFailedWithoutParams() {
        let expectation = XCTestExpectation(description: "Expect failed request")
        
        let request = FlightRequest()
        
        dataManager.searchFlights(request) { (response, error) in
            XCTAssertNotNil(error, "Should return error object")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
