//
//  AppDataStructures.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/3/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import Foundation
import UIKit

struct Icons {
    static let refreshIcon = "refresh"
}

struct AppColors {
    static let appBarsColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
    static let statusBarColor =  UIColor(red: 0.125, green: 0.337, blue: 0.353, alpha: 1.00)
    static let viewBackGroundColor =  UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1.00)
}

struct AppFonts {
    static let titlesFont = "AppleSDGothicNeo-Bold"
    static let classCellTitleFont = "AppleSDGothicNeo-Thin"
}


enum SpreadSheets:String {
    case Breakouts = "Breakouts"
    case Speakers = "Speakers"
    case Presentations = "Presentations"
    case Schedules = "Schedules"
}

enum AppManagedObject:String {
    case Breakout = "Breakout"
    case Speaker = "Speaker"
    case Presentation = "Presentation"
    case ScheduleItem = "ScheduleItem"
    case PersonalScheduleItem = "PersonalScheduleItem"
}

enum UserDefaultsKeyNames:String {
    case FirstLaunch = "FirstLaunch"
}

struct PossiblePersonalScheduleItem {
    var breakout:Breakout?
    var presentation:Presentation?
    var speaker:Speaker?
    var scheduleItem:ScheduleItem?
    
    init(breakout:Breakout?, presentation:Presentation?, speaker:Speaker?, scheduleItem:ScheduleItem?) {
        self.breakout = breakout
        self.presentation = presentation
        self.speaker = speaker
        self.scheduleItem = scheduleItem
    }
}

