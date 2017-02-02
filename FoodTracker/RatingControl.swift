//
//  RatingControl.swift
//  FoodTracker
//
//  Created by user124807 on 1/30/17.
//  Copyright © 2017 Darshan Nayak. All rights reserved.
//
/*
 This file has the code required to make the Custom Rating Control. Acts as a View.
 */

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0{
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        
        didSet {
            setupButtons()  //Adds new buttons with the updated sizes
        }
        
    } //Button Size
    
    @IBInspectable var starCount: Int = 5{
        
        didSet {
            setupButtons()
        }
        
    }   //Number of buttons
    
    
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
        //print("Button pressed!!") //Used to print message to colsole; for debugging only
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    //MARK: Private Methods
    
    private func setupButtons() {
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        for index in 0..<starCount {
            // Create the button
            let button = UIButton() //Button Created programatically!
            //button.backgroundColor = UIColor.green    //Button color set to green
            // Set the button images instead of solid color which was the output of the above commented code
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            // Constraints of the button
            button.translatesAutoresizingMaskIntoConstraints = false//Auto generated constraints cancelled.NOTE:not required, but good practice (Stack view automatically sets it to false even if you dont)
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true   //Manual constraint(height)
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true    //Manual constraint(width)
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)   //Links element to code, fires on TouchUpInside. No @IBAction required here!!
            addArrangedSubview(button)  //Add the button to the stack
            
            ratingButtons.append(button)    //Add the ith button to the ratingButtons array
            
        }
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating  //Useful when decreasing rating of already rated value
            
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set." //Singular
            default:
                valueString = "\(rating) stars set." //Plural
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
