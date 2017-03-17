//
//  Meal.swift
//  FoodTracker
//
//  Created by Richard Ju on 3/14/17.
//
//

import UIKit
import os.log

// name = string, photo = UIImage (optional), rating = int

class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        
        //Initialization failed
        guard !name.isEmpty else { return nil } // name must not be empty
        guard (rating >= 0) && (rating <= 5) else { return nil } // ratings must be from 0 to 5
        
        //Initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: Types
    struct PropertyKey {
        
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        //Name is required - Initializer should fail if we cannot decode a name string
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            
            os_log("Unable to decode the name for a Meal object", log: OSLog.default, type: .debug)
            return nil
        }
        
        //Photo is optional - therefore use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        //Rating is an integer - therefore no need to downcast
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        //Must call designated initalizer
        self.init(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
}
