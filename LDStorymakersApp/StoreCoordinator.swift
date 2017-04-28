//
//  StoreCoordinator.swift
//  LDStorymakersApp
//
//  Created by Gamaliel Tellez on 4/12/17.
//  Copyright © 2017 Gamaliel Tellez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class StoreCoordinator:NSObject {
    static let storeCoordinator = StoreCoordinator()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(completion:(_ succes:Bool)-> Void) {
        do {
            try self.context.save()
            completion(true)
        } catch let error {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    
    func delete(object:NSManagedObject) {
        self.context.delete(object)
        self.save { (saved) in
        }
    }
}


