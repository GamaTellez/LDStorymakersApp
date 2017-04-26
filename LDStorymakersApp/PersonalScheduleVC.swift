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
    let personalScheduleDataSource:PersonalScheduleDataSource = PersonalScheduleDataSource()
    var fridayBreakouts:[Breakout]?
    var saturdayBreakouts:[Breakout]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getBreakoutsForDataSource()
        self.setUpDaySegmentedController()
        self.setUpPersonalScheduleTableView()
        self.loadTableViewData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadTableViewData()
    }
    
    private func loadTableViewData() {
        let breakoutsSorted = Breakout.getAllBreakoutsSortedByDate()
        guard let friday = breakoutsSorted.0 else {
            return
        }
        self.fridayBreakouts = friday
        guard let saturday = breakoutsSorted.1 else {
            return
        }
        self.saturdayBreakouts = saturday
        if (self.daySegementedControl.selectedSegmentIndex == 0) {
            self.personalScheduleDataSource.updateDayBreakouts(with: friday)
        }
        if (self.daySegementedControl.selectedSegmentIndex == 1) {
            self.personalScheduleDataSource.updateDayBreakouts(with: saturday)
        }
        self.personalScheduleGroupedTableView.reloadData()
    }

    private func setUpDaySegmentedController() {
        self.daySegementedControl.selectedSegmentIndex = 0
    }
    
    
    private func setUpPersonalScheduleTableView() {
        self.personalScheduleGroupedTableView.dataSource = self.personalScheduleDataSource
        self.personalScheduleGroupedTableView.delegate = self
        self.personalScheduleGroupedTableView.backgroundColor = UIColor.clear
    }
    
    
    @IBAction func daySegmentedControllerToggled(_ sender: AppSegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            guard let friday = self.fridayBreakouts else {
                return
            }
            self.personalScheduleDataSource.updateDayBreakouts(with: friday)
        }
        if (sender.selectedSegmentIndex == 1) {
            guard let saturday = self.saturdayBreakouts else {
                return
            }
            self.personalScheduleDataSource.updateDayBreakouts(with: saturday)
        }
        self.personalScheduleGroupedTableView.reloadData()
    }
    /***********************************************************************
     * tableview delegate
     ************************************************************************/
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let breakoutString = self.getBreakoutAtIndex(section: section)?.breakoutID else {
            return 80
        }
        if (breakoutString.characters.count > 2) {
            return 80
        } else {
            return 20
        }
        
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let breakoutAtIndex = self.getBreakoutAtIndex(section: section) else {
            return nil
        }
        
        return breakoutAtIndex.labelForHeaderViewForMandatoryBreakoutIn(tableView: tableView)
    }
    
    private func getBreakoutAtIndex(section:Int)-> Breakout? {
        if (self.daySegementedControl.selectedSegmentIndex == 0) {
                return self.fridayBreakouts?[section]
        } else {
                return self.saturdayBreakouts?[section]
        }
    }
    
}







