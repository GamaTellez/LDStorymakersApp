//
//  BreakoutsDataSource.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/9/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class BreakoutsDataSource: NSObject, UITableViewDataSource {
   // let kBreakoutCellId = "breakoutCellId"
    private var dayBreakouts:[Breakout]?

    func updateBreakoutsArray(newBreakouts:[Breakout]) {
            self.dayBreakouts = newBreakouts
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.dayBreakouts != nil else {
            return 0
        }
        return self.dayBreakouts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreakoutCell.identifier , for: indexPath) as! BreakoutCell
        guard self.dayBreakouts?[indexPath.row] != nil,
            let breakoutTimes = self.dayBreakouts?[indexPath.row].breakoutShortFormatTimes(),
            let breakoutId = self.dayBreakouts?[indexPath.row].breakoutID else {
                cell.breakoutInfoLabel.text = "No info available"
                return cell
        }
        cell.breakoutInfoLabel.text = String(format:"Breakout %@ \n %@", breakoutId, breakoutTimes)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
