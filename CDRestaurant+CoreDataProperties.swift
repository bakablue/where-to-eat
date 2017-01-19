//
//  CDRestaurant+CoreDataProperties.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 12/01/2017.
//  Copyright © 2017 Wellcut. All rights reserved.
//

import Foundation
import CoreData


extension CDRestaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRestaurant> {
        return NSFetchRequest<CDRestaurant>(entityName: "CDRestaurant");
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var mediumPrice: Int64

}
