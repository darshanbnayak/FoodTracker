//
//  Meal.swift
//  FoodTracker
//
//  Created by user124807 on 1/30/17.
//  Copyright © 2017 Darshan Nayak. All rights reserved.
//

import UIKit    //Also gives access to Foundation, so no need to add it explicitly

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage? //Optional because sometimes a photo may not be provided
    var rating: Int
    
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) { // ? suggests that the init is failable, returns optional values (optional Meal? object)
        
        guard !name.isEmpty else {  //guard for empty name
            return nil
        }
        
        
        guard (rating >= 0) && (rating <= 5) else { //guard to check rating between 0 and 5, all-inclusive
            return nil
        }
        //Initialize
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
}
