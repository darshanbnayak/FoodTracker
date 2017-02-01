//
//  Meal.swift
//  FoodTracker
//
//  Created by user124807 on 1/30/17.
//  Copyright © 2017 Darshan Nayak. All rights reserved.
//

import UIKit    //Also gives access to Foundation, so no need to add it explicitly
import os.log



class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage? //Optional because sometimes a photo may not be provided
    var rating: Int
    
    
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    

    
    
    //MARK: Types
    
    struct PropertyKey {
        
        
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        

    }
    

    
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
    
    
    //MARK: NSCoding
    
    
    func encode(with aCoder: NSCoder) {
        
        
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        

    }
    
    
    
    required convenience init?(coder aDecoder: NSCoder) {   //convenience modifier means that this is a secondary initializer, and that it must call a designated initializer from the same class.
        
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage    //decodeObject is different than what the Apple documentation said. Check the documentation
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating) //decodeObject is different than what the Apple documentation said. Check the documentation
        
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
        

        

    }
    

    

}
