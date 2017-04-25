//
//  PersonalScheduleVC.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/24/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class PersonalScheduleVC: AppViewController, UITableViewDelegate {

    @IBOutlet var daySegementedControl: AppSegmentedControl!
    @IBOutlet var personalScheduleGroupedTableView: UITableView!
    var fridayBreakouts:[Breakout]?
    var saturdayBreakouts:[Breakout]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpDaySegmentedController()
        self.setUpPersonalScheduleTableView()
    }

    private func setUpDaySegmentedController() {
        self.daySegementedControl.selectedSegmentIndex = 0
    }
    
    
    private func setUpPersonalScheduleTableView() {
            
    }
    
    
    @IBAction func daySegmentedControllerToggled(_ sender: AppSegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            
        }
        if (sender.selectedSegmentIndex == 1) {
            
        }
    }



}
