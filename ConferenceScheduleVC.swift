//
//  ConferenceScheduleVC.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/9/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class ConferenceScheduleVC: AppViewController {
    @IBOutlet var daySegmentedController: AppSegmentedControl!
    @IBOutlet var breakoutsTableView: UITableView!
    var brakoutsForDaySelected:Breakout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    func setUpViews() {
        self.daySegmentedController.selectedSegmentIndex = 0
    }
    
    //Mark: initial set up for views
    private func viewsInitialSetUp() {
        self.daySegmentedController.selectedSegmentIndex = 0
    }
    
    @IBAction func daySegmentedControllerTapped(_ sender: AppSegmentedControl) {
        
    }
}
