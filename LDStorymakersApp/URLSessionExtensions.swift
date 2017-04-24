//
//  URLSessionExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 11/9/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import Foundation
//general spreadsheet is the url used for all spreadsheets
private let generalSpreadSheetLink = "https://spreadsheets.google.com/tq?key="
//mainspreadsheet, contains the keys for every spreadsheet needed(speakers, breakouts, classes, etc)
private let mainSpreadSheetKey = "1Y8jMldIfTCOdiirkINlMHJNij1C_ura01Ol40AwZxHs"

extension URLSession {
    /*****************************************************************************
     * gets the spreadsheet keys stored in userdefaults, with a completion value
     * of type bool
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
     * it gets the spreadsheet data for the given entityName
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
}



