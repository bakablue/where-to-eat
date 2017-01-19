//
//  Restaurant+CoreDataProperties.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 12/01/2017.
//  Copyright © 2017 Wellcut. All rights reserved.
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant");
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var mediumPrice: Int64

}
