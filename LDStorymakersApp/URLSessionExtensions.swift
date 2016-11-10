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


/*****************************************************************************
 * gets the spreadsheet keys stored in userdefaults, with a completion value
 * of type bool
 *****************************************************************************/
private extension URL {
    func getAllSpreadSheetkeys(completion:@escaping (_ success:Bool)-> Void) {
        guard let mainSpreadSheetURL = URL(string: generalSpreadSheetLink + mainSpreadSheetKey) else {
            completion(false)
            return
        }
        let taskForSpreadSheetKeys = URLSession.shared.dataTask(with: mainSpreadSheetURL) { (data:Data?, response:URLResponse?, error:Error?) in
            guard error == nil else {
                print(error?.localizedDescription)
                completion(false)
                return
            }
        
        }
        taskForSpreadSheetKeys.resume()
    }
}
