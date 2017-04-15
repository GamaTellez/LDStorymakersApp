//
//  ScheduleItem.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/12/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import Foundation
import CoreData

extension ScheduleItem {
    
   static func createScheduleItemFromInfoArray(_ arrayWithInfoDicts:NSArray) {
        let newItemSchedule = NSEntityDescription.insertNewObject(forEntityName: AppManagedObject.ScheduleItem.rawValue, into: StoreCoordinator().context) as! ScheduleItem
        if let scheduleIdDictionary = arrayWithInfoDicts[0] as? NSDictionary {
            if let schID = scheduleIdDictionary.object(forKey: "v") as? Int {
                //newItemSchedule.setValue(NSNumber(value: schID as Int), forKey: "scheduleId")
                newItemSchedule.scheduleID = Int16(schID)
            }
        }
        
        if let itemPresentationTitleDict = arrayWithInfoDicts[1] as? NSDictionary {
            if let title = itemPresentationTitleDict.object(forKey: "v") as? String {
                //newItemSchedule.setValue(title, forKey: "presentationTitle")
                newItemSchedule.presentationTitle = title
            }
        }
        if let itemPresentationIdDict = arrayWithInfoDicts[2] as? NSDictionary {
            if let idNum = itemPresentationIdDict.object(forKey: "v") as? Int {
                //newItemSchedule.setValue(NSNumber(value: idNum as Int), forKey: "presentationId")
                newItemSchedule.presentationID = Int16(idNum)
            }
        }
        
        if let itemBreakoutIdDict = arrayWithInfoDicts[3] as? NSDictionary {
            // print(itemBreakoutIdDict)
            if let idNum = itemBreakoutIdDict.object(forKey: "v") as? Int {
                //newItemSchedule.setValue(NSNumber(value: idNum as Int), forKey: "breakout")
                newItemSchedule.breakout = Int16(idNum)
            }
            if let idString = itemBreakoutIdDict.object(forKey: "f") as? String {
                //newItemSchedule.setValue(idString, forKey: "breakoutID")
                newItemSchedule.breakoutID = idString
            }
        }
        
        if let itemSectionDictionary = arrayWithInfoDicts[4] as? NSDictionary {
            if let sect = itemSectionDictionary.object(forKey: "v") as? Int {
                //newItemSchedule.setValue(sect, forKey: "section")
                newItemSchedule.section = Int16(sect)
            }
        }
        //not sure what data type is location goinng to be but most likely string
        if let itemLocationDictionary = arrayWithInfoDicts[5] as? NSDictionary {
            if let location = itemLocationDictionary.object(forKey: "v") as? String {
                //newItemSchedule.setValue(location, forKey: "location")
                newItemSchedule.location = location
            }
        }
        if let itemIsPresentationDictionaty = arrayWithInfoDicts[6] as? NSDictionary {
            if let isPresentation = itemIsPresentationDictionaty.object(forKey: "v") as? String {
                if isPresentation == "Yes" {
                    //newItemSchedule.setValue(NSNumber(value: true as Bool), forKey: "isPresentation")
                    newItemSchedule.isPresentation = true
                } else {
                    //newItemSchedule.setValue(NSNumber(value: false as Bool), forKey: "isPresentation")
                    newItemSchedule.isPresentation = false
                }
            }
        }
        if let itemTimeIdDictionary = arrayWithInfoDicts[7] as? NSDictionary {
            if let timeId = itemTimeIdDictionary.object(forKey: "v") as? Int {
                //newItemSchedule.setValue(NSNumber(integerLiteral: timeId), forKey: "timeId")
                newItemSchedule.timeID = Int16(timeId)
            }
        }
    }

}
