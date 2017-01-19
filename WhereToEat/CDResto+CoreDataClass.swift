//
//  CDResto+CoreDataClass.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 12/01/2017.
//  Copyright © 2017 Wellcut. All rights reserved.
//

import Foundation
import CoreData

@objc(CDResto)
public class CDResto: NSManagedObject {
    func getResto() -> Resto {
        var resto = Resto(name: name!, address: address!, style: Resto.Style.none)
        
        if style != nil {
            let styleValue = Resto.Style(rawValue: style!)
            
            if styleValue != nil {
                resto.style = styleValue!
            }
        }

        resto.note = UInt(grade)
        resto.mediumPrice = UInt(mediumPrice)
        
        if lastVisit != nil {
            resto.lastVisit = lastVisit as? Date
        }
        
        return resto
    }
    
    func loadResto(_ resto : Resto) {
        name = resto.name
        address = resto.address
        
        if resto.mediumPrice != nil {
            mediumPrice = Int16(resto.mediumPrice!)
        }
        
        if lastVisit != nil {
            lastVisit = resto.lastVisit! as NSDate
        }
        
        if resto.note != nil {
            grade = Int16(resto.note!)
        }
        if resto.mediumPrice != nil {
            mediumPrice = Int16(resto.mediumPrice!)
        }
    }
}
