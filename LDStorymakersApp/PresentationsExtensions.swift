//
//  PresentationsExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/12/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import Foundation
import CoreData


extension Presentation {
   static func createPresentationFromInfoArray(_ arrayWithInfoDicts:NSArray) {
        let newPresentation = NSEntityDescription.insertNewObject(forEntityName: AppManagedObject.Presentation.rawValue, into: StoreCoordinator().context)
        
        if let idDictionary = arrayWithInfoDicts[0] as? NSDictionary {
            if let id = idDictionary.object(forKey: "v") as? Int {
                newPresentation.setValue( NSNumber(integerLiteral:id), forKey: "id")
            }
        }
        if let titleDictionary = arrayWithInfoDicts[1] as? NSDictionary {
            if let title = titleDictionary.object(forKey: "v") as? String {
                newPresentation.setValue(title, forKey: "title")
            }
        }
        if let descriptionDictionary = arrayWithInfoDicts[2] as? NSDictionary {
            if let descript = descriptionDictionary.object(forKey: "v") as? String {
                newPresentation.setValue(descript, forKey: "presentationDescription")
            }
        }
        if let speakerDictionary = arrayWithInfoDicts[3] as? NSDictionary {
            if let speaker = speakerDictionary.object(forKey: "v") as? String {
                newPresentation.setValue(speaker, forKey: "speakerName")
            }
        }
        if let speakerIdDictionary =  arrayWithInfoDicts[4] as? NSDictionary {
            if let speakerId = speakerIdDictionary.object(forKey: "v") as? Int  {
                newPresentation.setValue(NSNumber(integerLiteral:speakerId), forKey: "speakerId")
            }
        }
        if let presentationKindDictionaty = arrayWithInfoDicts[5] as? NSDictionary {
            if let kind = presentationKindDictionaty.object(forKey: "v") as? String {
                if kind == "Yes" {
                    newPresentation.setValue(NSNumber(value: true as Bool), forKey: "isIntensive")
                } else {
                    newPresentation.setValue(NSNumber(value: false as Bool), forKey: "isIntensive")
                }
            }
        }
        if let presentationSection = arrayWithInfoDicts[6] as? NSDictionary {
            if let sect = presentationSection.object(forKey: "v") as? Int {
                newPresentation.setValue(NSNumber(integerLiteral: sect), forKey: "sectionId")
            }
        }
        StoreCoordinator().save { (saved) in
            if (!saved) {
                print("Failed to save the presentation")
            }
        }
    }
}


