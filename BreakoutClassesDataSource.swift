//
//  BreakoutClassesDataSource.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/18/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class BreakoutClassesDataSource: NSObject, UITableViewDataSource, PersonalScheduleModifiedDelegate {
    var classScheduleItems:[PossiblePersonalScheduleItem] = [PossiblePersonalScheduleItem]()
    var navControllerDelegate:AppNavigationController?
    var viewDelegate:UIView?
    
    internal func updateDataSourceArray(with classes:[PossiblePersonalScheduleItem], navControllerDelegate:AppNavigationController, viewDelegate:UIView) {
        self.classScheduleItems = classes
        self.navControllerDelegate = navControllerDelegate
        self.viewDelegate = viewDelegate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classScheduleItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreakoutClassCell.identifier, for: indexPath) as! BreakoutClassCell
        let classAtIndex = self.classScheduleItems[indexPath.row]
        cell.classItem = classAtIndex
        cell.delegate = self
        cell.loadInfoInCellViews()
        cell.contentView.setNeedsDisplay()
        return cell
    }

    func classRemovedFromSchedule() {
        
        guard let navigationController = self.navControllerDelegate,
            let view = self.viewDelegate else {
                return
        }
        UIAlertController.personalScheduleModified(message: PersonalScheduleModifiedKeywords.classRemoved, sourceView: view, navigationController: navigationController)
    }
    
    func classAddedToSchedule() {
        guard let navigationController = self.navControllerDelegate,
            let view = self.viewDelegate else {
                return
        }
        UIAlertController.personalScheduleModified(message: PersonalScheduleModifiedKeywords.classAdded, sourceView: view, navigationController:navigationController)
    }
}
