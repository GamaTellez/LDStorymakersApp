//
//  HomeViewController.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/3/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class HomeViewController: AppViewController {

    @IBOutlet var nextClassTitleLabel: UILabel!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var nextClassInfoView: UIView!
    @IBOutlet var nextClassTitle: AppLabelGeneral!
    @IBOutlet var nextClassTime: AppLabelGeneral!
    @IBOutlet var nextTimeLocation: AppLabelGeneral!
    @IBOutlet var nextClasDescription: AppLabelGeneral!
    @IBOutlet var upcomingClassesTitleaLabel: UILabel!
    @IBOutlet var upcomingClasesTableView: UITableView!
    lazy var defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        if ((self.defaults.value(forKey: UserDefaultsKeyNames.FirstLaunch.rawValue)) == nil) {
           self.appFirstLaunch()
        }
        
    }
    
    private func setUpViews() {
        //Mark:refresButton set up
        self.refreshButton.setImage(UIImage(named: Icons.refreshIcon), for: .normal)
        self.refreshButton.setTitleColor(.white, for: .normal)
    }
    
    private func appFirstLaunch() {
            self.getConferenceInformation { (finished) in
                if (finished) {
                    self.defaults.set(false, forKey: UserDefaultsKeyNames.FirstLaunch.rawValue)
                } else {
                    print("failed to get conference data")
                }
        }
    }
    
    
    private func getConferenceInformation(completion:@escaping (Bool)-> Void) {
        URLSession.getAllSpreadSheetkeys { (finished) in
            URLSession.downloadSpreadSheetData(for: .Breakouts, completion: { (finished) in
                if (finished) {
                    print("finished downloading breakouts")
                    URLSession.downloadSpreadSheetData(for: .Presentations, completion: { (finished) in
                        if (finished) {
                            print("finished downloading presentations")
                            URLSession.downloadSpreadSheetData(for: .Schedules, completion: { (finished) in
                                if (finished) {
                                    print("print finished downloading Schedule")
                                    URLSession.downloadSpreadSheetData(for: .Speakers, completion: { (finished) in
                                        if (finished) {
                                            print("print finished downloading speakers")
                                            completion(true)
                                        }
                                    })
                                }
                            })
                        }
                    })
                }
            })
        }
    }
}
