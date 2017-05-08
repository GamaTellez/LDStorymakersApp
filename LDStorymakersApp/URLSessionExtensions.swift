//
//  URLSessionExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 11/9/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import Foundation
import UIKit
//general spreadsheet is the url used for all spreadsheets
private let generalSpreadSheetLink = "https://spreadsheets.google.com/tq?key="
//mainspreadsheet, contains the keys for every spreadsheet needed(speakers, breakouts, classes, etc)
private let mainSpreadSheetKey = "1Y8jMldIfTCOdiirkINlMHJNij1C_ura01Ol40AwZxHs"

extension URLSession {
    /*****************************************************************************
     * gets the spreadsheet keys stored in userdefaults
     *****************************************************************************/
    static func getAllSpreadSheetkeys(completion:@escaping (_ success:Bool)-> Void) {
        guard let mainSpreadSheetURL = URL(string: generalSpreadSheetLink + mainSpreadSheetKey) else {
            completion(false)
            return
        }
        let taskForSpreadSheetKeys = self.shared.dataTask(with: mainSpreadSheetURL) { (data:Data?, response:URLResponse?, error:Error?) in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(false)
                return
            }
            guard let javaStringData = data else {
                completion(false)
                return
            }
            guard let jsonData = String.parseJSonString(from: javaStringData) else {
                completion(false)
                return
            }
            DispatchQueue.main.async {
                do {
                    let pureJson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                    // print(pureJson)
                    UserDefaults.saveLinksToUserDefaults(from: pureJson)
                    completion(true)
                } catch let error  as NSError {
                    print(error.localizedDescription)
                    completion(false)
                }
            }
        }
        taskForSpreadSheetKeys.resume()
    }
    
    /*****************************************************************************
     * it gets the spreadsheet data for the given entityName, 
     *****************************************************************************/
    static func downloadSpreadSheetData(for entity: SpreadSheets, completion: @escaping (_ finished:Bool) -> Void) {
    let defaults = UserDefaults()
        guard let spreadSheetKey = defaults.object(forKey: entity.rawValue) as? String else {
            completion(false)
            return
        }
        guard let entitySpreadSheetURL = URL(string: generalSpreadSheetLink + spreadSheetKey) else {
            completion(false)
            return
        }
        let dataTask = self.shared.dataTask(with: entitySpreadSheetURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if (error == nil) {
                guard let stringResponseAsData = data else {
                    completion(false)
                    return
                }
                guard let jsonStringAsData = String.parseJSonString(from: stringResponseAsData) else {
                    completion(false)
                    return
                }
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonStringAsData, options: .mutableContainers) as? [String:Any]
                    guard let infoDictionaries = extractInfoDictioariesFromJsonDictionary(jsonDict: jsonObject!) else {
                        completion(false)
                        return
                    }
                    //print(infoDictionaries)
                    DispatchQueue.main.async {
                        for objectDictionary in infoDictionaries {
                            if let arrayWithInfo = objectDictionary["c"] as? NSArray {
                                switch entity {
                                case .Breakouts:
                                    Breakout.createBreakoutFromInfoArray(arrayWithInfo)
                                    break
                                case .Presentations:
                                    Presentation.createPresentationFromInfoArray(arrayWithInfo)
                                    break
                                case .Speakers:
                                    Speaker.createSpeakerFromInfoArray(arrayWithInfo)
                                    break
                                case .Schedules:
                                    ScheduleItem.createScheduleItemFromInfoArray(arrayWithInfo)
                                    break
                                }
                            }
                        }
                        completion(true)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription + "when trying to save links")
                }
            }
        }
        dataTask.resume()
    }
    
    static func extractInfoDictioariesFromJsonDictionary(jsonDict:[String:Any]) -> [[String:Any]]? {
        guard let tableDictionary = jsonDict["table"] as? [String:Any] else {
            return nil
        }
        guard let arrayOfRowsDict = tableDictionary["rows"] as? [[String:Any]] else {
            return nil
        }
        return arrayOfRowsDict
    }
    
    static func openCourseFeedBack(classTitle:String) {
        let defaults = UserDefaults()
        guard let classFeedbackLinkString = defaults.value(forKey: "CourseLink") as? String,
            let classFeedBackKey = defaults.value(forKey: "Course Feedback") as? String,
            let className = classTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let classFeedBackURL = URL(string: classFeedbackLinkString + classFeedBackKey + className)
            else {
                print("failed to get course feed back link")
                return
        }
        UIApplication.shared.open(classFeedBackURL, options: [:], completionHandler: nil)

    }
    
    
    static func getConferenceInformation(completion:@escaping (Bool)-> Void) {
        URLSession.getAllSpreadSheetkeys { (finished) in
            if (finished) {
                URLSession.downloadSpreadSheetData(for: .Breakouts, completion: { (finished) in
                    if (finished) {
                        print("finished downloading breakouts")
                        URLSession.downloadSpreadSheetData(for: .Presentations, completion: { (finished) in
                            if (finished) {
                                print("finished downloading presentations")
                                URLSession.downloadSpreadSheetData(for: .Schedules, completion: { (finished) in
                                    if (finished) {
                                        print("finished downloading Schedule")
                                        URLSession.downloadSpreadSheetData(for: .Speakers, completion: { (finished) in
                                            if (finished) {
                                                print("finished downloading speakers")
                                                completion(true)
                                            }
                                        })
                                    }
                                })
                            }
                        })
                    }
                })
            } else {
                print("failed to get spreadsheet links")
            }
        }
    }
    
    static func refreshAllConferenceData(completion:@escaping (Bool)-> Void) {
        Breakout.deleteBreakouts { (finished) in
            if (finished) {
                Speaker.deleteSpeakers(completion: { (finished) in
                    if (finished) {
                        ScheduleItem.deleteSchedule(completion: { (finished) in
                            if (finished) {
                                Presentation.deletePresentations(completion: { (finished) in
                                    if (finished) {
                                        PersonalScheduleItem.delePersonalScheduleItems(completion: { (finished) in
                                            if (finished) {
                                                URLSession.getConferenceInformation(completion: { (finished) in
                                                    if (finished) {
                                                        completion(true)
                                                    } else {
                                                        completion(false)
                                                    }
                                                })
                                            }
                                        })
                                    }
                                })
                            }
                        })
                    }
                })
            }
        }
    }
    
    static func getConferenceNotifications(completion:@escaping ([ConferenceNotification]?)-> Void) {
        let defaults = UserDefaults()
        var conferenceNotifications:[ConferenceNotification]?
        
        if let notificationsURL = URL(string: generalSpreadSheetLink + defaults.string(forKey: "Notifications")!) {
            let dataTask = self.shared.dataTask(with: notificationsURL, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                if (error == nil) {
                    guard let jsonData = String.parseJSonString(from: data!) else {
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String:Any]
                        let spreadSheetArrayWithDictionaries = json["table"] as! [String:Any]
                        let arrayWithDictionaries = spreadSheetArrayWithDictionaries["rows"] as! [[String:Any]]
                        conferenceNotifications = [ConferenceNotification]()
                        for notificationDictionary in arrayWithDictionaries {
                            if let arrayWithInfoDictionaries = notificationDictionary["c"] as? [[String:Any]] {
                                conferenceNotifications?.append(ConferenceNotification(from: arrayWithInfoDictionaries))
                            }
                        }
                        completion(conferenceNotifications)
                    } catch {
                        completion(nil)
                        print(error.localizedDescription + "when getting notifications spreadsheet")
                    }
                }
            })
            dataTask.resume()
        }
    }
}




