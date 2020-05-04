//
//  PersonalScheduleDataSource.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/24/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class PersonalScheduleDataSource: NSObject, UITableViewDataSource {
    var dayBreakouts:[Breakout]?
    let findClassCellID = "findClassCell"
    
    internal func updateDayBreakouts(with breakouts:[Breakout]) {
        self.dayBreakouts = breakouts
    }
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard  let breakouts = self.dayBreakouts else {
            return 0
        }
        return breakouts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let personalScheduleItemsInBreakoutAtIndex = self.dayBreakouts?[section].personalScheduleItems?.array as? [PersonalScheduleItem],
                let breakoutAtIndex = self.dayBreakouts?[section] else {
            return 0
        }
        if (breakoutAtIndex.id > 12) {
            return 0
        } else {
        return personalScheduleItemsInBreakoutAtIndex.count + 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let personalScheduleItemsOfBreakoutAtIndex = self.dayBreakouts?[indexPath.section].personalScheduleItems?.array as? [PersonalScheduleItem] else {
            let findClassCell = tableView.dequeueReusableCell(withIdentifier: self.findClassCellID, for: indexPath)
            
            findClassCell.textLabel?.text = "Find Class"
            return findClassCell
        }
        if (indexPath.row == personalScheduleItemsOfBreakoutAtIndex.count) {
            let findClassCell = tableView.dequeueReusableCell(withIdentifier: self.findClassCellID, for: indexPath)
            findClassCell.textLabel?.text = "Find Class"
            return findClassCell
        }
        let personalScheduleItemAtIndex = personalScheduleItemsOfBreakoutAtIndex[indexPath.row]
        let scheduleItemCell = tableView.dequeueReusableCell(withIdentifier: PersonalScheduleCell.personalScheduleCellID, for: indexPath) as! PersonalScheduleCell
        scheduleItemCell.updateInfoLabel(with: personalScheduleItemAtIndex)
        return scheduleItemCell
    }
}
