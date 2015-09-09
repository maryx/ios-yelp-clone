//
//  ChoiceCell.swift
//  Yelp
//
//  Created by Mary Xia on 9/8/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol ChoiceCellDelegate {
    optional func choiceCell(choiceCell: ChoiceCell, didChangeValue value: Int)
}
class ChoiceCell: UITableViewCell {
    
    weak var delegate: ChoiceCellDelegate?
    
    @IBOutlet weak var choiceSegmentedControl: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        choiceSegmentedControl.addTarget(self, action: "choseSegment",
            forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func choseSegment() {
        delegate?.choiceCell?(self, didChangeValue: choiceSegmentedControl.selectedSegmentIndex)
    }
}
