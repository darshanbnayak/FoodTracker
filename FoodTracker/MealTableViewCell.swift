//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by user124807 on 1/31/17.
//  Copyright © 2017 Darshan Nayak. All rights reserved.
//
/*
 Here, we have set the blueprint for a UITableViewCell. One can say that it is a custom Cell for a table where we have added a Label of meal name, a rating control and an image of the meal
 as a part of one table cell. This blueprint is used in populating the table with cells, each cell denoting one meal.
 */

import UIKit

class MealTableViewCell: UITableViewCell {
    
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!  //Label for the meal name
    
    @IBOutlet weak var photoImageView: UIImageView! //image of the meal
    
    @IBOutlet weak var ratingControl: RatingControl!    //Rating of the meal
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
