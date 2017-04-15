//
//  BreakoutsExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/12/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import Foundation
import CoreData

extension Breakout {
    static func createBreakoutFromInfoArray(_ arrayWithInfoDictionaries:NSArray) {
            let newBreakout = NSEntityDescription.insertNewObject(forEntityName: "Breakout", into: StoreCoordinator().context) as! Breakout
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            //dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC−07")
            dateFormatter.timeZone = TimeZone(abbreviation: "MST")
            var dateDay = ""
            if let dictWithBreakoutID = arrayWithInfoDictionaries[0] as? NSDictionary {
                if let id = dictWithBreakoutID.object(forKey: "v") as? String {
                    //newBreakout.setValue(id, forKey: "breakoutID")
                    newBreakout.breakoutID = id
                }
            }
            if let breakoutDayDate = arrayWithInfoDictionaries[3] as? NSDictionary {
                if let dayDate = breakoutDayDate.object(forKey: "f") as? String {
                    dateDay = dayDate
                }
            }
        
            if let breakoutIDDict = arrayWithInfoDictionaries[4] as? NSDictionary {
                //print(breakoutIDDict)
                if let breakId = breakoutIDDict.object(forKey: "v") as? Int {
                    //newBreakout.setValue(NSNumber(value: breakId as Int), forKey: "id")
                    newBreakout.id = Int16(breakId)
                }
            }
            
            if let dictionayWithBreakoutStartTime = arrayWithInfoDictionaries[1] as? NSDictionary {
                if let stringStartTime = dictionayWithBreakoutStartTime.object(forKey: "f") as? String {
                    let fullStartTimeString = String(format: "%@ %@", dateDay, stringStartTime)
                    if let startDate = dateFormatter.date(from: fullStartTimeString) {
                        //newBreakout.setValue(startDate, forKey: "startTime")
                        newBreakout.startTime = startDate as NSDate
                    } else {
                        print("no startDate")
                    }
                }
            }
            
            if let dictionaryWithBreakoutEndTime = arrayWithInfoDictionaries[2] as? NSDictionary {
                if let stringEndTime = dictionaryWithBreakoutEndTime.object(forKey: "f") as? String {
                    let fullEndTimeString = String(format: "%@ %@", dateDay, stringEndTime)
                    if let endDate = dateFormatter.date(from: fullEndTimeString) {
                       // newBreakout.setValue(endDate, forKey: "endTime")
                        newBreakout.endTime = endDate as NSDate
                    } else {
                        print("no end date")
                    }
                }
            }
        StoreCoordinator().save { (saved) in
            if (saved) {
               // print("breakout saved")
            } else {
                print("failed to save break out")
            }
        }
    }
    
    static func getBreakoutsByDay(day:String)-> [Breakout]? {
        do  {
            let allBreakouts = try StoreCoordinator().context.fetch(Breakout.fetchRequest()) as [Breakout]
                return allBreakouts
            } catch {
            print(error.localizedDescription)
            }
            return nil
        }
//    static func getAllGoals() -> [Goal]? {
//        do {
//            let allGoals = try PersistantStorageCoordinator().context.fetch(Goal.fetchRequest())
//            return allGoals as? [Goal]
//        } catch {
//            print(error.localizedDescription)
//            return nil
//        }
//    }

}
