//
//  SwiftyStarsTests.swift
//  SwiftyStarsTests
//
//  Created by Hussein Jaber on 15/10/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import XCTest
@testable import SwiftyStars

class SwiftyStarsTests: XCTestCase {
    
    var starsView: StarsView!

    override func setUp() {
        starsView = StarsView()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSettingNumberOfStarsPerformance() {
        self.measure {
            starsView.numberOfStars = 10
            starsView.currentRating = 5
        }
    }

   

}
