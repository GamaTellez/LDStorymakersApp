//
//  SpeakersExtensions.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/12/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

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
    
    static func getSpeakerOfPresentation(thePresentation:Presentation?)-> Speaker? {
        guard let theSpeakerId = thePresentation?.speakerId else {
            return nil
        }
        do {
            let allSpeakers = try StoreCoordinator().context.fetch(Speaker.fetchRequest()) as [Speaker]
            for currentSpeaker in allSpeakers {
                if (currentSpeaker.speakerID == theSpeakerId) {
                    return currentSpeaker
                }
            }
        } catch {
            return nil
        }
        return nil
    }
    
    /*****************************************************************************
     * get image
     *****************************************************************************/
    //    if let speakerName = self.speakerSelected?.valueForKey("imageName") as? String {
    //        NSURLSessionController.sharedInstance.getSpeakerPhotoData(speakerName, completion: { (photoData) -> Void in
    //            dispatch_async(dispatch_get_main_queue(), { () -> Void in
    //                if let imageData = photoData {
    //                    self.speakerImageView.image = UIImage(data: imageData)
    //                    self.activityIndicator.stopAnimating()
    //                    self.activityIndicator.alpha = 0
    //                } else {
    //                    self.imageFetchFailAlert()
    //                }
    //            })
    //        })
    //    }
    //}
    func getImage()-> UIImage? {
        let cloudinaryStringURL = "https://res-4.cloudinary.com/innatemobile/image/upload/v1492531068/"
        guard let imageURL = URL(string: cloudinaryStringURL + self.imageName!.replacingOccurrences(of: " ", with: "_")) else {
            return nil
        }
        do {
            let imageData = try Data(contentsOf: imageURL)
            guard let image = UIImage(data: imageData) else {
                return nil
            }
            return image
        } catch {
            print(error.localizedDescription + "when getting image data")
            return nil
        }
    }
    
}














