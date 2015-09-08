//
//  SwitchCell.swift
//  Yelp
//
//  Created by Mary Xia on 9/7/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}
class SwitchCell: UITableViewCell {

    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!

    weak var delegate: SwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        toggleSwitch.addTarget(self, action: "toggledSwitch",
            forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func toggledSwitch() {
        delegate?.switchCell?(self, didChangeValue: toggleSwitch.on)
        // equivalent to below
        //        if (delegate != nil) {
        //            delegate!.switchCell?(self, didChangeValue: toggleSwitch.on)
        //        }

        
    }
}
