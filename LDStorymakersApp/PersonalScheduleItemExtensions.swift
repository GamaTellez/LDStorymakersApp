//
//  PersonalScheduleItemExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/21/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import Foundation
import CoreData

extension PersonalScheduleItem {
    
    static func personalScheduleItemsForBreakout(breakout:Breakout?, speaker:Speaker?, presentation:Presentation?, itemSchedule:ScheduleItem?, completion: (_ finished:Bool)-> Void) {
        let newPersonalScheduleItem = NSEntityDescription.insertNewObject(forEntityName: AppManagedObject.PersonalScheduleItem.rawValue, into: StoreCoordinator().context) as! PersonalScheduleItem
        newPersonalScheduleItem.breakout = breakout
        newPersonalScheduleItem.speaker = speaker
        newPersonalScheduleItem.presentation = presentation
        newPersonalScheduleItem.scheduleItem = itemSchedule
        StoreCoordinator().save { (saved) in
            if (!saved) {
                print("failed to save new speaker")
                completion(false)
            } else {
                completion(false)
            }
        }
    }
}
