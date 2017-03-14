//
//  Meal.swift
//  FoodTracker
//
//  Created by Richard Ju on 3/14/17.
//
//

import UIKit

// name = string, photo = UIImage (optional), rating = int

class Meal {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        
        //Initialization failed
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        //Initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
