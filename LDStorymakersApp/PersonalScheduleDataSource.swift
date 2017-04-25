//
//  PersonalScheduleDataSource.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/24/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class PersonalScheduleDataSource: NSObject, UITableViewDataSource {
    var personalScheduleClasses:[PersonalScheduleItem] = [PersonalScheduleItem]()
    var dayBreakouts:[Breakout] = [Breakout]()
    
    internal func updatePersonalScheduleArray(with classes:[PersonalScheduleItem]) {
        self.personalScheduleClasses.removeAll()
        self.personalScheduleClasses = classes
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dayBreakouts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personalScheduleClasses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return PersonalScheduleCell()
    }
}
