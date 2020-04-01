//
//  OtherExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 11/9/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import Foundation
import UIKit

/******************************************************************************
 * it takes the data from calling the google spreadsheets.
 * the spreadsheets return a javastring containg a dictionary. this
 * function filters that dictionary and returns it as data so it can
 * be parse into a json object for easy manypulation
 * it is done this waty because the storymakers are cheap and dont want to spend
 * money on an actual cloud service
 ******************************************************************************/
extension String {
    static func parseJSonString(from dataString:Data) -> Data? {
        guard let stringFromData = NSString(data: dataString, encoding: String.Encoding.utf8.rawValue) else {
            return (nil)
        }
        let firstSubString = stringFromData.substring(from: stringFromData.range(of: "{").location)
        let firstSubStringObject = NSString(string: firstSubString)
        let jsonString = firstSubStringObject.substring(to: firstSubStringObject.range(of: "}", options: .backwards).location + 1)
        guard let jsonStringAsData = jsonString.data(using: String.Encoding.utf8) else {
            return(nil)
        }
        return (jsonStringAsData)
    }
}

extension UserDefaults {
    //Mark:get saved spreadsheet links
    static func saveLinksToUserDefaults(from jsonObject:Any) {
        if let jsonDictionary = jsonObject as? NSDictionary {
            if let tableDict = jsonDictionary.object(forKey: "table") {
                if let rowsArray = (tableDict as AnyObject).object(forKey: "rows") {
                    //print(rowsArray)
                    self.save(rowsArray)
                }
            }
        }
    }
    
    static func save(_ arrayOfDictionaries:Any) {
        let defaults = UserDefaults()
        let dictionariesInArray = arrayOfDictionaries as! [NSDictionary]
        for dictionary in dictionariesInArray {
            var nameKey:String?
            if let dictionaryWithObject = dictionary.object(forKey: "c") as? NSArray {
                if let dictionaryWithNameKey = dictionaryWithObject[1] as? NSDictionary {
                    if let stringName = dictionaryWithNameKey.object(forKey: "v") as? String {
                        nameKey = stringName
                        if stringName == "Conference Feedback" {
                            if let dictWithConferenceLink = dictionaryWithObject[2] as? NSDictionary {
                                if let conferenceFeedBacLink = dictWithConferenceLink.object(forKey: "v") as? String {
                                    defaults.set(conferenceFeedBacLink, forKey: "ConferenceLink")
                                }
                            }
                        }
                        if stringName == "Course Feedback" {
                            if let dictWithCourseLink = dictionaryWithObject[2] as? NSDictionary {
                                if let courseFeedBacLink = dictWithCourseLink.object(forKey: "v") as? String {
                                    defaults.set(courseFeedBacLink, forKey: "CourseLink")
                                }
                            }
                        }
                    }
                }
                
                var spreadSheetKey:String?
                if let dictionaryWithSpreadSheetKey = dictionaryWithObject[3] as? NSDictionary {
                    if let stringSpreadSheetKey = dictionaryWithSpreadSheetKey.object(forKey: "v") as? String {
                        spreadSheetKey = stringSpreadSheetKey
                    }
                }
                print(nameKey! + " = " + spreadSheetKey!)
                defaults.set(spreadSheetKey, forKey: nameKey!)
                defaults.synchronize()
            } else {
                print("failed to get dictionary")
            }
        }
    }

}

//Mark:adds the background view to the area where the status bar is
extension UIView {
    static func addStatusBarBackGroundView(at x:CGFloat, y:CGFloat)-> UIView {
            let statusBarView = UIView(frame: CGRect(x: x, y: y, width: UIScreen.main.bounds.width, height: 22))
            statusBarView.backgroundColor = AppColors.statusBarColor
        return statusBarView
    }

    static func downloadingInformationView(frame:CGRect)-> UIView {
        let loadingView = UIView(frame: frame)
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.center = loadingView.center
        loadingView.addSubview(activityIndicator)
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Downloading Conference Schedule..."
        label.font = UIFont(name: AppFonts.titlesFont, size: 15)
        label.frame.size = CGSize(width: loadingView.frame.width, height: loadingView.frame.width)
        label.center = CGPoint(x: loadingView.center.x, y: loadingView.center.y + activityIndicator.frame.height + 40)
        loadingView.addSubview(label)
        loadingView.alpha = 0
        return loadingView
    }
    
    static func presentViewWithDuration(view:UIView) {
        UIView.animate(withDuration: 2) { 
            view.alpha = 1
        }
    }
    
    static func removeViewWithDelay(view:UIView) {
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) { 
            UIView.animate(withDuration: 2, animations: {
                view.alpha = 1
            }) { (finished) in
                view.removeFromSuperview()
            }
        }
    }
}


extension UIAlertController {
    static func personalScheduleModified(message:PersonalScheduleModifiedKeywords, sourceView:UIView, navigationController:UINavigationController) {
            let personalScheduleModifiedAlert = UIAlertController(title: message.rawValue, message: nil, preferredStyle: .alert)
        personalScheduleModifiedAlert.popoverPresentationController?.sourceView = sourceView
        personalScheduleModifiedAlert.popoverPresentationController?.sourceRect = sourceView.bounds
        navigationController.present(personalScheduleModifiedAlert, animated: true) { 
            let delay = 0.5 * Double(NSEC_PER_SEC)
            let time = DispatchTime.init(uptimeNanoseconds: UInt64(delay))
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                navigationController.dismiss(animated: true, completion: nil)
                })
            }
    }
}



















