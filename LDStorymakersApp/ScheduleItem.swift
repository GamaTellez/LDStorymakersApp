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
        if let scheduleIdDictionary = arrayWithInfoDicts[0] as? [String:Any] {
            if let schID = scheduleIdDictionary["v"] as? Int {
                //newItemSchedule.setValue(NSNumber(value: schID as Int), forKey: "scheduleId")
                newItemSchedule.scheduleID = Int16(schID)
            }
        }
        
        if let itemPresentationTitleDict = arrayWithInfoDicts[1] as? [String:Any] {
            if let title = itemPresentationTitleDict["v"] as? String {
                //newItemSchedule.setValue(title, forKey: "presentationTitle")
                newItemSchedule.presentationTitle = title
            }
        }
        if let itemPresentationIdDict = arrayWithInfoDicts[2] as? [String:Any] {
            if let idNum = itemPresentationIdDict["v"] as? Int {
                //newItemSchedule.setValue(NSNumber(value: idNum as Int), forKey: "presentationId")
                newItemSchedule.presentationID = Int16(idNum)
            }
        }
        
    if let itemBreakoutIdDict = arrayWithInfoDicts[3] as? [String:Any] {
            if let breakoutId = itemBreakoutIdDict["f"] as? String {
                newItemSchedule.breakout = breakoutId
            }
        }
    
        if let itemSectionDictionary = arrayWithInfoDicts[4] as? [String:Any] {
            if let sect = itemSectionDictionary["v"] as? Int {
                //newItemSchedule.setValue(sect, forKey: "section")
                newItemSchedule.section = Int16(sect)
            }
        }
        //not sure what data type is location goinng to be but most likely string
        if let itemLocationDictionary = arrayWithInfoDicts[5] as? [String:Any] {
            if let location = itemLocationDictionary["v"] as? String {
                //newItemSchedule.setValue(location, forKey: "location")
                newItemSchedule.location = location
            }
        }
        if let itemIsPresentationDictionaty = arrayWithInfoDicts[6] as? [String:Any] {
            if let isPresentation = itemIsPresentationDictionaty["v"] as? String {
                if isPresentation == "Yes" {
                    //newItemSchedule.setValue(NSNumber(value: true as Bool), forKey: "isPresentation")
                    newItemSchedule.isPresentation = true
                } else {
                    //newItemSchedule.setValue(NSNumber(value: false as Bool), forKey: "isPresentation")
                    newItemSchedule.isPresentation = false
                }
            }
        }
        if let itemTimeIdDictionary = arrayWithInfoDicts[7] as? [String:Any] {
            if let timeId = itemTimeIdDictionary["v"] as? Int {
                //newItemSchedule.setValue(NSNumber(integerLiteral: timeId), forKey: "timeId")
                newItemSchedule.timeID = Int16(timeId)
                
            }
        }
    StoreCoordinator().save { (saved) in
        if (!saved) {
            print("failed to save new speaker")
        }
    }
    }
    
    static func getAllScheduleItems(with title:String)-> [ScheduleItem]? {
        var matchingScheduleItems:[ScheduleItem] = [ScheduleItem]()
        do {
            let allItems = try StoreCoordinator().context.fetch(ScheduleItem.fetchRequest()) as [ScheduleItem]
            for item in allItems {
                if let itemTitle = item.presentationTitle {
                    if (itemTitle == title) {
                        matchingScheduleItems.append(item)
                    }
                }
            }
            return matchingScheduleItems
        } catch {
            print(error.localizedDescription + "when fecthing matching schedule items to title")
            return nil
        }
    }
    
    static func deleteSchedule(completion:(_ finished:Bool)-> Void) {
        do {
            let allSchedules = try StoreCoordinator().context.fetch(ScheduleItem.fetchRequest()) as [ScheduleItem]
            for item in allSchedules {
                StoreCoordinator().context.delete(item)
            }
        } catch {
            print (error.localizedDescription)
        }
        completion(true)
    }
}








