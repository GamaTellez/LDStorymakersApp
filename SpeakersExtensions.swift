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
        let newSpeaker = NSEntityDescription.insertNewObject(forEntityName: AppManagedObject.Speaker.rawValue, into: StoreCoordinator().context)
        
        if let dictionaryWithId = arrayWithInfoDicts[0] as? NSDictionary {
            if let id = dictionaryWithId.object(forKey: "v") as? Int {
                newSpeaker.setValue(NSNumber(value: id as Int), forKey: "speakerId")
            }
        }
        
        if let dictionaryWithName = arrayWithInfoDicts[1] as? NSDictionary {
            if let name = dictionaryWithName.object(forKey: "v") as? String {
                newSpeaker.setValue(name, forKey: "speakerName")
            }
        }
        if let dictionaryWithBio = arrayWithInfoDicts[2] as? NSDictionary {
            if let bio = dictionaryWithBio.object(forKey: "v") as? String {
                newSpeaker.setValue(bio, forKey: "speakerBio")
            }
        }
        if let dictionaryWithImageName = arrayWithInfoDicts[3] as? NSDictionary {
            if let imageName = dictionaryWithImageName.object(forKey: "v") as? String {
                newSpeaker.setValue(imageName, forKey: "imageName")
            }
        }
        StoreCoordinator().save { (saved) in
            if (!saved) {
                print("failed to save new speaker")
            }
        }
    }
}
