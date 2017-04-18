//
//  ConferenceScheduleVC.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/9/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class ConferenceScheduleVC: AppViewController, UITableViewDelegate {
    @IBOutlet var daySegmentedController: AppSegmentedControl!
    @IBOutlet var breakoutsTableView: UITableView!
    var breakoutsTableDataSource:BreakoutsDataSource = BreakoutsDataSource()
    var dayOneBreakouts:[Breakout]?
    var dayTwoBreakouts:[Breakout]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBreakoutsForDataSource()
        self.setUpViews()
    }
    
    func setUpViews() {
        self.tableViewSetUp()
        self.title = "Conference Schedule"
        self.daySegmentedController.selectedSegmentIndex = 0
        
    }
    
    private func tableViewSetUp() {
        self.breakoutsTableView.backgroundColor = UIColor.clear
        self.breakoutsTableView.dataSource = self.breakoutsTableDataSource
        self.breakoutsTableView.delegate = self
        guard  let currentDayBreakouts = self.dayOneBreakouts else {
            self.breakoutsTableDataSource.updateBreakoutsArray(newBreakouts: [Breakout]())
            return
        }
        self.breakoutsTableDataSource.updateBreakoutsArray(newBreakouts: currentDayBreakouts)
    }
    
    @IBAction func daySegmentedControllerTapped(_ sender: AppSegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            guard let dayOne = self.dayOneBreakouts else {
                return
            }
            self.breakoutsTableDataSource.updateBreakoutsArray(newBreakouts: dayOne)
            self.breakoutsTableView.reloadData()
        }
    
        if (sender.selectedSegmentIndex == 1) {
            guard let dayTwo = self.dayOneBreakouts else {
                return
            }
            self.breakoutsTableDataSource.updateBreakoutsArray(newBreakouts: dayTwo)
            self.breakoutsTableView.reloadData()
        }
    }
    
    private func getBreakoutsForDataSource() {
        let breakouts = Breakout.getBreakouts()
        guard let dayOne = breakouts.0 else {
            return
        }
        self.dayOneBreakouts = dayOne
        guard let dayTwo = breakouts.1 else {
            return
        }
        self.dayTwoBreakouts = dayTwo
    }
    
    //Mark: tableview delegate methoda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}





