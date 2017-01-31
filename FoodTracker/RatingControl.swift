//
//  RatingControl.swift
//  FoodTracker
//
//  Created by user124807 on 1/30/17.
//  Copyright © 2017 Darshan Nayak. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)    //superclass's initializer
        setupButtons()
        
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)    //superclass's initializer
        setupButtons()
        
    }
    
    //MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed!!")
    }
    //MARK: Private Methods
    
    private func setupButtons() {
        
        // Create the button
        let button = UIButton() //Button Created programatically!
        button.backgroundColor = UIColor.green    //Button color set to green
        
        // Constraints of the button
        button.translatesAutoresizingMaskIntoConstraints = false//Auto generated constraints cancelled.NOTE:not required, but good practice (Stack view automatically sets it to false even if you dont)
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true   //Manual constraint(height)
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true    //Manual constraint(width)
        
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)   //Links element to code, fires on TouchUpInside. No @IBAction required here!!
        addArrangedSubview(button)  //Add the button to the stack
    }
}
