//
//  MemeTableViewCell.swift
//  ImagePickerTest
//
//  Created by Kevin Duck on 5/26/15.
//  Copyright (c) 2015 Kevin Duck. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //Cell selected
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
