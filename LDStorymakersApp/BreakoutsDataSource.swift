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
    private var breakouts:[Breakout] = [Breakout]()

    func updateBreakoutsArray(newBreakouts:[Breakout]) {
            self.breakouts = newBreakouts
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.kBreakoutCellId, for: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.breakouts.count
    }
}
