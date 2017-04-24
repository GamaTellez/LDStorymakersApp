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
            if let dictWithBreakoutID = arrayWithInfoDictionaries[0] as? [String:Any] {
                if let id = dictWithBreakoutID["v"] as? String {
                    //newBreakout.setValue(id, forKey: "breakoutID")
                    newBreakout.breakoutID = id
                }
            }
            if let breakoutDayDate = arrayWithInfoDictionaries[3] as? [String:Any] {
                if let dayDate = breakoutDayDate["f"] as? String {
                    dateDay = dayDate
                }
            }
        
            if let breakoutIDDict = arrayWithInfoDictionaries[4] as? [String:Any] {
                //print(breakoutIDDict)
                if let breakId = breakoutIDDict["v"] as? Int {
                    //newBreakout.setValue(NSNumber(value: breakId as Int), forKey: "id")
                    newBreakout.id = Int16(breakId)
                }            }
            
            if let dictionayWithBreakoutStartTime = arrayWithInfoDictionaries[1] as? [String:Any] {
                if let stringStartTime = dictionayWithBreakoutStartTime["f"] as? String {
                    let fullStartTimeString = String(format: "%@ %@", dateDay, stringStartTime)
                    if let startDate = dateFormatter.date(from: fullStartTimeString) {
                        //newBreakout.setValue(startDate, forKey: "startTime")
                        newBreakout.startTime = startDate as NSDate
                    } else {
                        print("no startDate")
                    }
                }
            }
            
            if let dictionaryWithBreakoutEndTime = arrayWithInfoDictionaries[2] as? [String:Any] {
                if let stringEndTime = dictionaryWithBreakoutEndTime["f"] as? String {
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
    //Mark: returns all breakouts stored in two arrays (dayOne= first six breakouts, day two:last six breakouts)
    static func getBreakouts()-> ([Breakout]?, [Breakout]?) {
        var dayOneBreakouts:[Breakout] = [Breakout]()
        var dayTwoBreakouts:[Breakout] = [Breakout]()
        do  {
            let allBreakouts = try StoreCoordinator().context.fetch(Breakout.fetchRequest()) as [Breakout]
            if (!allBreakouts.isEmpty) {
            for i in 0..<allBreakouts.count {
                if (i <= 5) {
                    dayOneBreakouts.append(allBreakouts[i])
                } else if (i > 5 && i <= 11) {
                    dayTwoBreakouts.append(allBreakouts[i])
                }
            }
                return (dayOneBreakouts, dayTwoBreakouts)
            } else {
                return (nil, nil)
            }
            } catch {
                print(error.localizedDescription + " failed to fecth brakouts")
                return (nil, nil)
        }
    }

    
    //Mark:gets the breakout start and end time as a readable string
        func breakoutShortFormatTimes() -> String {
            guard let startTime = self.startTime else {
                return ("Time not available")
            }
            //let startTimeString = self.localizedString(from: startTime as Date, dateStyle: .none, timeStyle: .short)
            guard let endTime = self.endTime else {
                return ("Time not Available")
            }
            return String(format:"%@ - %@", DateFormatter.localizedString(from: startTime as Date, dateStyle: .none, timeStyle: .short), DateFormatter.localizedString(from: endTime as Date, dateStyle: .none, timeStyle: .short))
        }
    
    func getBreakoutDay()-> String? {
        guard let dayDate = self.startTime else {
            return nil
        }
        let day = Calendar.current.component(.weekday, from: dayDate as Date)
        if (day == 6) {
            return "Friday"
        } else {
            return "Saturday"
        }
    }
    
    func getAllScheduleItemsInBreakout()-> [ScheduleItem]? {
        var breakoutScheduleItems:[ScheduleItem] = [ScheduleItem]()
        if let breakoutSelectedId = self.breakoutID {
            do {
                let allScheduleItems = try StoreCoordinator().context.fetch(ScheduleItem.fetchRequest()) as [ScheduleItem]
                if (!allScheduleItems.isEmpty) {
                    for item in allScheduleItems {
                        if (item.isPresentation) {
                            if let itemBreakout = item.breakout {
                                if (itemBreakout == breakoutSelectedId) {
                                    breakoutScheduleItems.append(item)
                                }
                            }
                        }
                    }
                }
                return breakoutScheduleItems
            } catch {
                print(error.localizedDescription + " fetching the schedule items")
                return nil
            }
        }
        return breakoutScheduleItems
    }
    
    func getBreakoutPossiblePersonalItemSchedule()-> [PossiblePersonalScheduleItem]? {
        guard let allScheduleItemsInBreakout = self.getAllScheduleItemsInBreakout() else {
            return nil
        }
        var possiblePersonalScheduleItems:[PossiblePersonalScheduleItem] = [PossiblePersonalScheduleItem]()
        for item in allScheduleItemsInBreakout {
            let itemPresentation = Presentation.getPresentationForScheduleItem(item: item)
            let presentationSpeaker = Speaker.getSpeakerOfPresentation(thePresentation: itemPresentation)
            possiblePersonalScheduleItems.append(PossiblePersonalScheduleItem(breakout: self, presentation: itemPresentation, speaker: presentationSpeaker, scheduleItem: item))
        }
        return possiblePersonalScheduleItems
    }
}
