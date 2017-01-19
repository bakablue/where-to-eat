//
//  Directory.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 01/12/2016.
//  Copyright © 2016 Wellcut. All rights reserved.
//

import Foundation
import CloudKit
import CoreData
import UIKit


class Directory {
    static var shared = Directory()
    
    var notificationCenter = NotificationCenter.default
    
    private init() {
    }
    
    private var restaurants : [Resto] = []
    func add(restaurant : Resto) {
        restaurants.append(restaurant)
        notificationCenter.post(Notification(name: Notification.Name(rawValue: "restoAdded")))
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entityResto = CDResto(context: context)
        entityResto.loadResto(restaurant)
        do {
           try context.save()
            print("saved !")
            
        } catch {
            // FIXME
        }
        
        /*let container = CKContainer.default()
        let pubDB = container.publicCloudDatabase
        
        
        let restoRecord = CKRecord(recordType: "Restaurant")
        restoRecord["name"] = restaurant.name as CKRecordValue?
        restoRecord["address"] = restaurant.address as CKRecordValue?
        restoRecord["mediumPrice"] = restaurant.mediumPrice as CKRecordValue?
        
        pubDB.save(restoRecord) { (record, error) in
            if let e = error {
                // FIXME
            } else {
                print("Pushed")
            }
            
        }*/
    }
    func getAll() -> [Resto] {
        
        guard restaurants.count != 0 else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest : NSFetchRequest<CDResto> = CDResto.fetchRequest()
            
            do {
                let searchResults = try? context.fetch(fetchRequest)
                
                guard searchResults != nil else {
                    return restaurants
                }
                for restaurantEntity in searchResults! as [CDResto] {
                    
                    restaurants.append(restaurantEntity.getResto())
                }
            }
            return restaurants
        }
        

        return restaurants
    }
    func getRandom() -> Resto? {
        if (restaurants.count > 0) {
            let randomInt = Int(arc4random_uniform(UInt32(restaurants.count)))
            return restaurants[randomInt]
        }
        return nil;
    }
    func get(index: Int) -> Resto? {
        guard restaurants.count > 0 else {
            return nil
        }
        return restaurants[index]
    }
    
    func remove(index: Int) {
        guard restaurants.count > 0 else {
            return
        }
        let resto = restaurants[index]
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<CDResto> = CDResto.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND address == %@", resto.name, resto.address)
        do {
            let searchResults = try? context.fetch(fetchRequest)
            
            guard searchResults != nil else {
                return
            }
            for restaurantEntity in searchResults! as [CDResto] {
                context.delete(restaurantEntity)
            }
        
        } catch {
            // FIXME
        }
        restaurants.remove(at: index)
    }
}
