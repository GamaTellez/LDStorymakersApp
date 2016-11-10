//
//  OtherExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 11/9/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import Foundation

private extension NSString {
    func parseJSonString(from dataString:Data) -> (jsonData:Data?, success:Bool) {
        guard let stringFromData = NSString(data: dataString, encoding: String.Encoding.utf8.rawValue) else {
            return (nil, false)
        }
        let firstSubString = stringFromData.substring(from: stringFromData.range(of: "{").location)
        let firstSubStringObject = NSString(string: firstSubString)
        let jsonString = firstSubStringObject.substring(to: firstSubStringObject.range(of: "}", options: .backwards).location + 1)
        guard let jsonStringAsData = jsonString.data(using: String.Encoding.utf8) else {
            return(nil, false)
        }
        return (jsonStringAsData, true)
    }
}
