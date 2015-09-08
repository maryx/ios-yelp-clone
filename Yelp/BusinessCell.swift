//
//  BusinessCell.swift
//  Yelp
//
//  Created by Mary Xia on 9/4/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var starImageView: UIImageView!
    
    var business: Business! {
        didSet {
            addressLabel.text = business.address
            cuisineLabel.text = business.categories
            nameLabel.text = business.name
            distanceLabel.text = business.distance
            reviewLabel.text = "\(business.reviewCount!) opinionated people"
            restaurantImageView.setImageWithURL(business.imageURL)
            starImageView.setImageWithURL(business.ratingImageURL)
        }
    }

    override func awakeFromNib() { // cell instatiated
        super.awakeFromNib()
        restaurantImageView.layer.cornerRadius = 3
        restaurantImageView.clipsToBounds = true
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width // where the label should wrap
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width // where you change dimension (rotate phone)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
