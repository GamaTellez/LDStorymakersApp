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
    
    @IBOutlet var mapBarButton: UIBarButtonItem!
    var fridayBreakouts:[Breakout]?
    var saturdayBreakouts:[Breakout]?
    lazy var userDefaults:UserDefaults = UserDefaults()
    var loadingView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getBreakoutsForDataSource()
            self.title = "LDStorymakers 2019"
        self.mapBarButton.image = UIImage(named: "map")?.withRenderingMode(.alwaysTemplate)
        self.mapBarButton.tintColor = UIColor.white
        self.setUpDaySegmentedController()
        self.setUpPersonalScheduleTableView()
        self.appFirstLaunch()
        self.loadTableViewData()
    }
    
    
    
    private func appFirstLaunch() {
        guard (self.userDefaults.value(forKey: "firstLaunch") != nil) else {
            if let appTabBar = self.tabBarController as? AppTapBarController {
                appTabBar.enableTabBarItems(enabled: false)
            }
            self.loadingView = UIView.downloadingInformationView(frame: self.view.bounds)
            //UIView.presentViewWithDuration(view: self.loadingView!)
            self.view.addSubview(self.loadingView!)
            URLSession.getConferenceInformation(completion: { (finished) in
                if (finished) {
                    self.userDefaults.setValue(false, forKey: "firstLaunch")
                    DispatchQueue.main.async {
                        UIView.removeViewWithDelay(view: self.loadingView!)
                    }
                    self.loadTableViewData()
                    if let appTabBar = self.tabBarController as? AppTapBarController {
                        appTabBar.enableTabBarItems(enabled: true)
                    }
                } else {
                        print("couldn get data")
                }
            })
            return
        }
        
    }
    
    @IBAction func mapBarButtonItempTapped(_ sender: UIBarButtonItem) {
        guard let mapURL = URL(string: "http://www.utahvalleyconventioncenter.com/wp-content/uploads/2011/11/All-Levels-Floor-Plan-w%EF%80%A2-cap1.pdf") else {
            return
        }
        UIApplication.shared.open(mapURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
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
        if (breakoutString.count > 2) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let personalItems = self.getBreakoutAtIndex(section: indexPath.section)?.personalScheduleItems?.array as? [PersonalScheduleItem] else {
            return
        }
        if (indexPath.row == personalItems.count) {
            self.pushBreakoutClassesViewController(with: self.getBreakoutAtIndex(section: indexPath.section))
        } else {
            self.pushClassDetailViewController(from: personalItems[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard let breakOutAtIndex = self.getBreakoutAtIndex(section: indexPath.section) else {
            return .none
        }
        if (breakOutAtIndex.personalScheduleItems?.count != indexPath.row) {
            return .delete
        } else {
            return .none
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Remove") { (contextualAtion, view, true) in
            if let allPersonalScheduleItems = self.getBreakoutAtIndex(section: indexPath.section)?.personalScheduleItems?.array as? [PersonalScheduleItem] {
                StoreCoordinator().delete(object: allPersonalScheduleItems[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    private func getBreakoutAtIndex(section:Int)-> Breakout? {
        if (self.daySegementedControl.selectedSegmentIndex == 0) {
                return self.fridayBreakouts?[section]
        } else {
                return self.saturdayBreakouts?[section]
        }
    }
    
    private func pushClassDetailViewController(from item:PersonalScheduleItem) {
        let itemDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "classDetailVC") as! ClassDetailView
        itemDetailsVC.classSelected = PossiblePersonalScheduleItem(breakout: item.breakout, presentation: item.presentation, speaker: item.speaker, scheduleItem: item.scheduleItem)
        self.navigationController?.pushViewController(itemDetailsVC, animated: true)
    }
    
    private func pushBreakoutClassesViewController(with selectedBreakout:Breakout?) {
        let breakoutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "breakoutClassesVC") as! BreakoutClassesVC
        if let theBreakout = selectedBreakout {
            guard let theBreakoutClasses = theBreakout.getBreakoutPossiblePersonalItemsSchedule(),
                let title = theBreakout.breakoutID else {
                    return
            }
            breakoutViewController.breakoutClasses = theBreakoutClasses
            breakoutViewController.title = String(format:"Breakout %@", title)
            breakoutViewController.breakoutTimeString = selectedBreakout?.breakoutShortFormatTimes()
            self.navigationController?.pushViewController(breakoutViewController, animated: true)
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
