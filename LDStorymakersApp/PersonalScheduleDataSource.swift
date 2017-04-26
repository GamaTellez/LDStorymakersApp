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
        guard let breakoutID = self.dayBreakouts?[section].breakoutID?.characters.count else {
            return 0
        }
        if (breakoutID < 3) {
            return 1
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let breakoutAtIndex = self.dayBreakouts?[indexPath.row],
                let classInBreakout = breakoutAtIndex.personalScheduleItem
            else {
                let findClassCell = tableView.dequeueReusableCell(withIdentifier: self.findClassCellID, for: indexPath)
                findClassCell.textLabel?.text = "Find Class"
                return findClassCell
        }
        let classScheduleCell = tableView.dequeueReusableCell(withIdentifier: PersonalScheduleCell.personalScheduleCellID, for: indexPath) as! PersonalScheduleCell
            classScheduleCell.updateInfoLabel(with: classInBreakout)
        return classScheduleCell
    }
    
}
