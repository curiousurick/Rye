//
//  HouseTableViewCell.swift
//  Login
//
//  Created by George Urick on 2/8/15.
//  Copyright (c) 2015 Jason Kwok. All rights reserved.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    
    
    @IBOutlet var programName: UILabel!
    @IBOutlet var address: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInfo(programName: ProgramNames, address: String) {
        self.programName.text = ""
        self.address.text = ""
        self.programName.text = programName.rawValue
        self.address.text = address
    }

}
