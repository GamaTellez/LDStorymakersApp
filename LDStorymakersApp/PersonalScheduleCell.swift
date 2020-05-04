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
        guard let presentationTitle =  classScheduled.presentation?.title,
                let presentationTime = classScheduled.breakout?.breakoutShortFormatTimes()
                    //let presentationLocation = classScheduled.scheduleItem?.location //Online due to covid
            else {
                self.classScheduledInfoLabel.text = "\n No Info Found"
            return
        }
        self.classScheduledInfoLabel.text = String(format:"%@ \n %@ \n", presentationTitle, presentationTime)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.classScheduledInfoLabel.numberOfLines = 0
        self.classScheduledInfoLabel.font = UIFont(name: AppFonts.classCellTitleFont, size: 17)
    }
}
