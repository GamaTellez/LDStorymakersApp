//
//  SpeakersExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/12/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import Foundation
import CoreData

extension Speaker {
    static func createSpeakerFromInfoArray(_ arrayWithInfoDicts:NSArray) {
        let newSpeaker = NSEntityDescription.insertNewObject(forEntityName: AppManagedObject.Speaker.rawValue, into: StoreCoordinator().context) as! Speaker
        
        if let dictionaryWithId = arrayWithInfoDicts[0] as? NSDictionary {
            if let id = dictionaryWithId.object(forKey: "v") as? Int {
                //newSpeaker.setValue(NSNumber(value: id as Int), forKey: "speakerId")
                newSpeaker.speakerID = Int16(id)
            }
        }
        
        if let dictionaryWithName = arrayWithInfoDicts[1] as? NSDictionary {
            if let name = dictionaryWithName.object(forKey: "v") as? String {
                //newSpeaker.setValue(name, forKey: "speakerName")
                newSpeaker.speakerName = name
            }
        }
        if let dictionaryWithBio = arrayWithInfoDicts[2] as? NSDictionary {
            if let bio = dictionaryWithBio.object(forKey: "v") as? String {
                //newSpeaker.setValue(bio, forKey: "speakerBio")
                newSpeaker.speakerBio = bio
            }
        }
        if let dictionaryWithImageName = arrayWithInfoDicts[3] as? NSDictionary {
            if let imageName = dictionaryWithImageName.object(forKey: "v") as? String {
                //newSpeaker.setValue(imageName, forKey: "imageName")
                newSpeaker.imageName = imageName
            }
        }
        StoreCoordinator().save { (saved) in
            if (!saved) {
                print("failed to save new speaker")
            }
        }
    }
}
