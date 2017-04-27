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
    
    static func createPersonalScheduleItem(fromo possibleItem:PossiblePersonalScheduleItem, completion:(_ saved:Bool)-> Void) {
        let newPersonalScheduleItem = NSEntityDescription.insertNewObject(forEntityName: AppManagedObject.PersonalScheduleItem.rawValue, into: StoreCoordinator().context) as! PersonalScheduleItem
        newPersonalScheduleItem.breakout = possibleItem.breakout
        possibleItem.breakout?.personalScheduleItem = newPersonalScheduleItem
        newPersonalScheduleItem.presentation = possibleItem.presentation
        newPersonalScheduleItem.scheduleItem = possibleItem.scheduleItem
        newPersonalScheduleItem.speaker = possibleItem.speaker
        StoreCoordinator().save { (saved) in
            if (saved) {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    static func findPersonalScheduleItem(with title:String)-> PersonalScheduleItem? {
        do {
            let allPersonalScheduleClasses = try StoreCoordinator().context.fetch(PersonalScheduleItem.fetchRequest()) as! [PersonalScheduleItem]
            for personalItem in allPersonalScheduleClasses {
                if let personalItemPresentationTitle = personalItem.presentation?.title {
                    if (personalItemPresentationTitle == title){
                        return personalItem
                    }
                }
            }
        } catch {
            print(error.localizedDescription + " " + "when fetching personal items")
            return nil
        }
        return nil
    }
}

