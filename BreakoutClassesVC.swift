//
//  BreakoutClassesVC.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/18/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class BreakoutClassesVC: AppViewController, UITableViewDelegate {

    @IBOutlet var breakoutTimeLabel: AppLabelGeneral!
    @IBOutlet var breakoutClassesTableView: UITableView!
    var breakoutTimeString:String?
    var breakoutClassesTableDataSource:BreakoutClassesDataSource = BreakoutClassesDataSource()
    var breakoutClasses:[PossiblePersonalScheduleItem]?
    let classDetailedSegueID = "classDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
        self.setBreakoutTimeLabel()
    }
    
    private func setUpTableView() {
        self.breakoutClassesTableView.delegate = self
        self.breakoutClassesTableView.dataSource = self.breakoutClassesTableDataSource
        self.breakoutClassesTableView.backgroundColor = UIColor.clear
        guard let breakoutClasses = self.breakoutClasses else {
            return
        }
        self.breakoutClassesTableDataSource.updateDataSourceArray(with: breakoutClasses)
        self.breakoutClassesTableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.breakoutClassesTableView.reloadData()
    }
    
    private func setBreakoutTimeLabel() {
        guard let timeString = self.breakoutTimeString else {
            self.breakoutTimeLabel.text = "Not Available"
            return
        }
        self.breakoutTimeLabel.text = timeString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = segue.identifier else {
            return
        }
        if (segueID == self.classDetailedSegueID) {
            guard let classSelected = self.breakoutClasses?[(self.breakoutClassesTableView.indexPathForSelectedRow?.row)!] else {
                return
            }
            let classDetailVC = segue.destination as! ClassDetailView
            classDetailVC.classSelected = classSelected
        }
    }
    
    
}
