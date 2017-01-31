//
//  RatingControl.swift
//  FoodTracker
//
//  Created by user124807 on 1/30/17.
//  Copyright © 2017 Darshan Nayak. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0
    
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
        print("Button pressed!!")
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
        
        
        for _ in 0..<starCount {
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
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)   //Links element to code, fires on TouchUpInside. No @IBAction required here!!
            addArrangedSubview(button)  //Add the button to the stack
            
            ratingButtons.append(button)    //Add the ith button to the ratingButtons array
        }
    }
}
