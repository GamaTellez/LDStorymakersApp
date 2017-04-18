//
//  BreakoutsDataSource.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/9/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class BreakoutsDataSource: NSObject, UITableViewDataSource {
    let kBreakoutCellId = "breakoutCellId"
    private var dayBreakouts:[Breakout] = [Breakout]()

    func updateBreakoutsArray(newBreakouts:[Breakout]) {
            self.dayBreakouts = newBreakouts
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dayBreakouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.kBreakoutCellId, for: indexPath) as! BreakoutCell
        let breakoutAtIndex = self.dayBreakouts[indexPath.row]
        cell.breakoutInfoLabel.text = String(format:"Breakout %@ \n %@", breakoutAtIndex.breakoutID!, breakoutAtIndex.breakoutShortFormatTimes())
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
