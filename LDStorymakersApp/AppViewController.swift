//
//  AppViewController.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/3/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpAppearance()
    }

    private func setUpAppearance() {
        self.view.backgroundColor = AppColors.viewBackGroundColor
        //self.view.addSubview(UIView.addStatusBarBackGroundView(at    : 0, y: 0))
    }
}
