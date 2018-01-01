//
//  AirportLocalDataManagerTests.swift
//  airticketsTests
//
//  Created by Paulo Rodrigues on 01/01/18.
//  Copyright © 2018 MaxMilhas. All rights reserved.
//

import XCTest
@testable import airtickets

class AirportLocalDataManagerTests: XCTestCase {
    
    let dataManager: AirportLocalDataManager = AirportLocalDataManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListAirportsSuccessfully() {
        let expectation = XCTestExpectation(description: "Expect successfully request")
        
        dataManager.listAirports { (response, error) in
            XCTAssertNotNil(response, "Should return an array")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
