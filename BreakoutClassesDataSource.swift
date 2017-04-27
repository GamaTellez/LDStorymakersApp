//
//  BreakoutClassesDataSource.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/18/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class BreakoutClassesDataSource: NSObject, UITableViewDataSource {
    var classScheduleItems:[PossiblePersonalScheduleItem] = [PossiblePersonalScheduleItem]()
    
    
    internal func updateDataSourceArray(with classes:[PossiblePersonalScheduleItem]) {
        self.classScheduleItems = classes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classScheduleItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreakoutClassCell.identifier, for: indexPath) as! BreakoutClassCell
        let classAtIndex = self.classScheduleItems[indexPath.row]
        cell.classItem = classAtIndex
        cell.loadInfoInCellViews()
        cell.contentView.setNeedsDisplay()
        return cell
    }
}
