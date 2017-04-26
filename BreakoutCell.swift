//
//  BreakoutCell.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/17/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class BreakoutCell: UITableViewCell {

    @IBOutlet var breakoutInfoLabel: UILabel!
    static let identifier = "breakoutCellId"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.breakoutInfoLabel.numberOfLines = 2
        self.breakoutInfoLabel.font = UIFont(name: AppFonts.titlesFont, size: 15)
        self.selectionStyle = .none
    }
}
