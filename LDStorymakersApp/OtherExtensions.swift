//
//  OtherExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 11/9/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import Foundation


/******************************************************************************
 * it takes the data from calling the google spreadsheets.
 * the spreadsheets return a javastring containg a dictionary. this
 * function filters that dictionary and returns it as data so it can
 * be parse into a json object for easy manypulation
 * it is done this waty because the storymakers are cheap and dont want to spend
 * money on an actual cloud service
 ******************************************************************************/
extension NSString {
    func parseJSonString(from dataString:Data) -> Data? {
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

private extension UserDefaults {
    func saveSpreadSheetKey() {
        
    }
}
