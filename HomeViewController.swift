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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        self.downloadingConferenceInformation()
    }
    
    private func setUpViews() {
        //Mark:refresButton set up
        self.refreshButton.setImage(UIImage(named: Icons.refreshIcon), for: .normal)
        self.refreshButton.setTitleColor(.white, for: .normal)
    }
    
    
    
    private func downloadingConferenceInformation() {
        URLSession.getAllSpreadSheetkeys { (finished) in
            URLSession.downloadSpreadSheetData(for: .Breakouts, completion: { (finished) in
                if (!finished) {
                    print("failed to create managed object")
                }
            })
        }
    }
    
}
