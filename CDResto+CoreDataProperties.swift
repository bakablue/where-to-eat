//
//  CDResto+CoreDataProperties.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 12/01/2017.
//  Copyright © 2017 Wellcut. All rights reserved.
//

import Foundation
import CoreData


extension CDResto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDResto> {
        return NSFetchRequest<CDResto>(entityName: "CDResto");
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var mediumPrice: Int16
    @NSManaged public var style: String?
    @NSManaged public var visited: Bool
    @NSManaged public var grade: Int16
    @NSManaged public var lastVisit: NSDate?

}
