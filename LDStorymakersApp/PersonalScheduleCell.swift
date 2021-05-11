//
//  PersonalScheduleCell.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/24/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class PersonalScheduleCell: UITableViewCell {
    static let personalScheduleCellID = "personalScheduleClassCell"
    @IBOutlet var classScheduledInfoLabel: UILabel!
    
    
    internal func updateInfoLabel(with classScheduled:PersonalScheduleItem) {
        var text = ""
        if let presentationTitle = classScheduled.presentation?.title {
            text += presentationTitle
        
        } else {
            if let title = classScheduled.scheduleItem?.presentationTitle {
              text += title
            } else {
                text += "No name available."
            }
        }
        if let time = classScheduled.breakout?.breakoutShortFormatTimes() {
            text += "\n \(time)"
        } else {
            text += "\n No time available."
        }
        if let location = classScheduled.scheduleItem?.location {
            text += "\n \(location)"
        } else {
            text += "\n No location available,"
        }
        self.classScheduledInfoLabel.text = text
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.classScheduledInfoLabel.numberOfLines = 0
        self.classScheduledInfoLabel.font = UIFont(name: AppFonts.classCellTitleFont, size: 17)
    }
}
