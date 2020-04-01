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
    var notificationsForConference:[ConferenceNotification]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTableView.dataSource = self
        self.settingsTableView.delegate = self
        self.titleLabel.text = "\nSettings"
        self.getConferenceNotications()
    }
    
    
    
    private func getConferenceNotications() {
        URLSession.getConferenceNotifications { (notifications) in
            guard let allNotifications = notifications else {
                return
            }
            self.notificationsForConference = allNotifications
            DispatchQueue.main.async {
                self.settingsTableView.reloadSections(IndexSet(integer:2), with: .left)
            }
        }
    }
    
    //Mark: tableview data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 2
        }
        if (section == 1) {
            return 1
        }
        if (section == 2) {
            guard let allnotifications = self.notificationsForConference else {
                return 0
            }
            return allnotifications.count + 1
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCellID", for: indexPath)
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel?.text = "Conference Feedback"
            } else {
                cell.textLabel?.text = "Course Feedback"
            }
        } else if (indexPath.section == 1) {
            cell.textLabel?.text = "Update Conference Schedule"
            cell.accessoryView = UIImageView(image: UIImage(named: "refresh"))
        } else {
            if (indexPath.row == 0) {
                cell.textLabel?.text = "Tap to get notifications"
                cell.textLabel?.textAlignment = .center
                cell.imageView?.image = nil
            } else {
            guard let notifiationAtIndex = self.notificationsForConference?[indexPath.row - 1] else {
                cell.textLabel?.text = "Not Info Available"
                return cell
            }
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = notifiationAtIndex.notificationMessage
            cell.isUserInteractionEnabled = false
            cell.imageView?.image = nil
            }
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    //Mark: tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                self.openConferenceFeedbackLink()
            }
            self.openCourseFeedbackLink()
                break
        case 2:
            if (indexPath.row == 0) {
                self.getConferenceNotications()
            }
        default:
            self.settingsTableView.isUserInteractionEnabled = false
            self.loadingView = UIView.downloadingInformationView(frame: self.view.frame)
            UIView.presentViewWithDuration(view: self.loadingView!)
            self.view.addSubview(self.loadingView!)
            URLSession.refreshAllConferenceData(completion: { (finished) in
                UIView.removeViewWithDelay(view: self.loadingView!)
                self.settingsTableView.isUserInteractionEnabled = true
            })
            break
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 2 && indexPath.row != 0) {
            return 200
        }
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Conference Feedback"
        }
        if (section == 1) {
            return "Conference Schedule"
        } else {
            return "Conference Notifications"
        }
    }
    
    private func openConferenceFeedbackLink() {
        guard let conferenceFeedbackURL = URL(string:(self.userDefaults.value(forKey: "ConferenceLink") as? String)!) else {
            return
        }
        UIApplication.shared.open(conferenceFeedbackURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    private func openCourseFeedbackLink() {
        guard let conferenceFeedbackURL = URL(string:(self.userDefaults.value(forKey: "CourseLink") as? String)!) else {
            return
        }
        UIApplication.shared.open(conferenceFeedbackURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }

    }












// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
