//
//  BreakoutsExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/12/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

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
                        newBreakout.startTime = startDate as Date
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
                        newBreakout.endTime = endDate as Date
                    } else {
                        print("no end date")
                    }
                }
            }
        StoreCoordinator().save { (saved) in
            if (saved) {
                print("\(arrayWithInfoDictionaries)\n\n--------------------------\n")
            } else {
                print("failed to save break out")
            }
        }
    }
    
    //gets all the breakouts for personal schedule view controller
    static func getAllBreakoutsSortedByDate()-> ([Breakout]? , [Breakout]?) {
        var fridayBreakouts:[Breakout] = [Breakout]()
        var saturdayBreakouts:[Breakout] = [Breakout]()
        do {
            let allBreakouts = try StoreCoordinator().context.fetch(Breakout.fetchRequest()) as [Breakout]
            let allBreakoutsSorted = allBreakouts.sorted(by: {$1.startTime! as Date > $0.startTime! as Date })
            var count = 0
            for breakoutItem in allBreakoutsSorted {
                if (breakoutItem.breakoutID != "Friday Teen Meetup" && breakoutItem.breakoutID != "Saturday Teen Meetup" ) {
                if (count < 14) {//so the are only 13 breakouts but there are two happening at the same time so just increaded by one
                    fridayBreakouts.append(breakoutItem)
                } else {
                    saturdayBreakouts.append(breakoutItem)
                }
                count += 1
                }
            }
            
            return (fridayBreakouts, saturdayBreakouts)
        } catch {
            print(error.localizedDescription + "when fectching all breakouts for personal schedule")
            return (nil, nil)
        }
    }
    
    //Mark: returns all breakouts stored in two arrays (dayOne= first six breakouts, day two:last six breakouts)
    static func getBreakoutsInDays()-> ([Breakout]?, [Breakout]?) {
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

    //Mark:gets all breakouts
    static func getAllBreakouts()-> [Breakout]? {
        do {
            let allBreakouts = try StoreCoordinator().context.fetch(Breakout.fetchRequest()) as [Breakout]
            return allBreakouts
        } catch {
            print(error.localizedDescription + "when fetching all breakouts")
            return nil
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            dateFormatter.timeZone = TimeZone(abbreviation: "MST")
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            let readableStartTime = dateFormatter.string(from: startTime)
            let readableEndTime = dateFormatter.string(from: endTime)
            return String(format: "%@ - %@", readableStartTime, readableEndTime)
//            return String(format:"%@ - %@", DateFormatter.localizedString(from: startTime as Date, dateStyle: .none, timeStyle: .short), DateFormatter.localizedString(from: endTime as Date, dateStyle: .none, timeStyle: .short))
        }
    //gets the day as a string of the breakout
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
    //gets all the items of the breakout instance
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
    ///creates intacnes of possible personal schedule for the current breakout
    func getBreakoutPossiblePersonalItemsSchedule()-> [PossiblePersonalScheduleItem]? {
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
    
    //creates the label for the section header of mandatory breakout in personal schedule view
     func labelForHeaderViewForMandatoryBreakoutIn(tableView:UITableView)-> UILabel? {
        if let breakoutIDString = self.breakoutID {
            if (breakoutIDString.count > 2) {
                let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
                headerLabel.font = UIFont(name: AppFonts.classCellTitleFont, size: 20)
                headerLabel.textAlignment = .center
                headerLabel.numberOfLines = 0
                guard let breakoutLocation = self.findLocationForBreakoutEvent() else {
                   // print("found nil when finding " + breakoutIDString)
                    headerLabel.text = String(format: "%@ \n %@", breakoutIDString, self.breakoutShortFormatTimes())
                    return headerLabel
                }
                headerLabel.text = String(format: "%@ \n %@ \n %@", breakoutIDString, self.breakoutShortFormatTimes(), breakoutLocation)
                return headerLabel
            } else {
                let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
                headerLabel.font = UIFont(name: AppFonts.titlesFont, size: 18)
                headerLabel.textAlignment = .left
                headerLabel.text = String(format:"Breakout, %@ %@" ,breakoutIDString, self.breakoutShortFormatTimes())
                return headerLabel
            }
        } else {
            return nil
        }
    }

    
    //finds the location for breakout event
    func findLocationForBreakoutEvent()-> String? {
        do {
             let scheduleItems = try StoreCoordinator().context.fetch(ScheduleItem.fetchRequest()) as [ScheduleItem]
                for itemSchedule in scheduleItems {
                        if (itemSchedule.timeID == self.id) {
                            return itemSchedule.location
                        }
                }
            return nil
            } catch {
                print(error.localizedDescription)
                return nil
            }
    }

    
    //Mark: finds the breakout with the given id int
    static func findBreakoutWithId(id:Int16)-> Breakout? {
        guard let allBreakouts = Breakout.getAllBreakouts() else {
            return nil
        }
        for breakoutItem in allBreakouts {
            if (breakoutItem.id == id) {
                return breakoutItem
            }
        }
        return nil
    }
    
    static func deleteBreakouts(completion:(_ finished:Bool)-> Void) {
        guard let allBreakouts = Breakout.getAllBreakouts() else {
            return
        }
        for itemBreakout  in allBreakouts {
            StoreCoordinator().delete(object: itemBreakout)
        }
        completion(true)
    }
}










