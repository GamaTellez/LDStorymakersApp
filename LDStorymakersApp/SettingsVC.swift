//
//  SettingsVC.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/28/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class SettingsVC: AppViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var titleLabel: AppTitleLabel!
    @IBOutlet var settingsTableView: UITableView!
    var loadingView:UIView?
    lazy var userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTableView.dataSource = self
        self.settingsTableView.delegate = self
        self.titleLabel.text = "\nSettings"
    }
    
    //Mark: tableview data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCellID", for: indexPath)
        if (indexPath.row == 0) {
            cell.textLabel?.text = "Conference Feedback"
        } else {
            cell.textLabel?.text = "Course Feedback"
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    //Mark: tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath.row == 0) {
            self.openConferenceFeedbackLink()
        } else {
            self.openCourseFeedbackLink()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Feedback"
    }
    
    
    
    private func openConferenceFeedbackLink() {
        guard let conferenceFeedbackURL = URL(string:(self.userDefaults.value(forKey: "ConferenceLink") as? String)!) else {
            return
        }
        UIApplication.shared.open(conferenceFeedbackURL, options: [:], completionHandler: nil)
    }
    
    private func openCourseFeedbackLink() {
        guard let conferenceFeedbackURL = URL(string:(self.userDefaults.value(forKey: "CourseLink") as? String)!) else {
            return
        }
        UIApplication.shared.open(conferenceFeedbackURL, options: [:], completionHandler: nil)
    }

    
}











