//
//  AppNavigationController.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/3/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.backgroundColor = AppColors.appBarsColor
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = AppColors.appBarsColor
        //self.navigationBar.addSubview(UIView.addStatusBarBackGroundView(at: 0, y: -20))
        self.navigationItem.backBarButtonItem?.title = " "
        guard let titleFont = UIFont(name: AppFonts.titlesFont, size: 20) else {
            return
        }
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: titleFont,
                                                NSAttributedString.Key.foregroundColor:UIColor.white]
    }
}
