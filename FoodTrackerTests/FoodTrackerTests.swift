//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by user124807 on 1/30/17.
//  Copyright © 2017 Darshan Nayak. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Meal Class Tests
    
    
    func testMealInitializationSucceeds() { // Confirm that the Meal initializer returns a Meal object when passed valid parameters.
        
        // Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        // Highest positive rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
        
        
    }
    
    
    func testMealInitializationFails() {    // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
        
        // Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // Rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        // Empty String
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
        
    }
    
    
}

//Summarizing Comments/Notes
/*
 If you write unit tests that are long or complicated, it’ll be harder to track down exactly what’s going wrong.
 While learning testing, try to force some tests to fail in order to see how testing reacts.
 */
