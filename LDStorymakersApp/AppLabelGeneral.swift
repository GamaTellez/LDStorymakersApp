//
//  AppLabelGeneral.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/3/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import UIKit

class AppLabelGeneral: UILabel {

    override func awakeFromNib() {
        self.font = UIFont(name: AppFonts.titlesFont, size: 20)
    }
    
}
