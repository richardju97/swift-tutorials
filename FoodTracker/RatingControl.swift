//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Richard Ju on 3/14/17.
//
//

import UIKit

class RatingControl: UIStackView {

//    MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
//    MARK: Private Methods
    private func setupButtons() {
        
//        Create the button
        let button = UIButton()
        button.backgroundColor = UIColor.red
        
//        Add Constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
//        Add the button to the stack
        addArrangedSubview(button)
    }
}
