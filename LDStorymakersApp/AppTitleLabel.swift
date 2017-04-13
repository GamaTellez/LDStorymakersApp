//
//  AppTitleLabel.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/3/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class AppTitleLabel: UILabel {
    override func awakeFromNib() {
        self.appearanceSetUp()
    }

    //MarK: appearance setup
    private func appearanceSetUp() {
        self.font =  UIFont(name: AppFonts.labelFont, size: 20)
        self.textColor = .white
        self.backgroundColor = AppColors.appBarsColor
    }
}
