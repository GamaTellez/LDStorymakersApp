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
    let kBreakoutClassesSegueId = "breakoutClassesSegueId"
    
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
        self.breakoutsTableView.backgroundColor = UIColor.clear
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
            guard let dayTwo = self.dayTwoBreakouts else {
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else {
            return
        }
        if (segueId == self.kBreakoutClassesSegueId) {
            var breakoutSelected:Breakout?
            if (self.daySegmentedController.selectedSegmentIndex == 0) {
                guard let breakoutTapped = self.dayOneBreakouts?[(self.breakoutsTableView.indexPathForSelectedRow?.row)!] else {
                    return
                }
                breakoutSelected = breakoutTapped
            }
            if (self.daySegmentedController.selectedSegmentIndex == 1) {
                guard let breakoutTapped = self.dayTwoBreakouts?[(self.breakoutsTableView.indexPathForSelectedRow?.row)!] else {
                    return
                }
                breakoutSelected = breakoutTapped
            }
            guard let theBreakout = breakoutSelected else {
                return
            }
            //print(theBreakout.breakoutID!)
            let selectedBreakoutClassesVC = segue.destination as! BreakoutClassesVC
            selectedBreakoutClassesVC.breakoutClasses = theBreakout.getBreakoutPossiblePersonalItemSchedule()
            selectedBreakoutClassesVC.title = String(format: "Breakout %@", theBreakout.breakoutID!)
            selectedBreakoutClassesVC.breakoutTimeString = theBreakout.breakoutShortFormatTimes()
        }
    }
}





