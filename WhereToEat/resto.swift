//
//  resto.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 01/12/2016.
//  Copyright © 2016 Wellcut. All rights reserved.
//

import Foundation


struct Resto {
    enum Style: String {
        case burger
        case pizza
        case salad
        case african
        case korean
        case none = "nothing"
        
        static var allStyles: [Style] {
            return [ .burger, .pizza, .salad, .none, african, .korean ]
        }
    }
    
    enum Specificity: String {
        case vegan
        case vegetarian
        case bio
        case homemade
        case glutenFree
        case hallal
        case lactoseFree
        case none = "no specificity"
        
        static var allSpecificities: [Specificity] {
            return [ .vegan, .vegetarian, .bio, .homemade, .glutenFree, .hallal, .lactoseFree, .none ]
        }
    }

    var name : String
    var address : String
    var style : Style
    var specificities : [Specificity]?
    var note : UInt?
    var mediumPrice : UInt?
    var lastVisit : Date?
    var hours : [String : (UInt, UInt)]?
    
    init(name : String, address : String, style: Style) {
        self.name = name
        self.address = address
        self.style = style
        self.note = nil
        self.mediumPrice = nil
        self.lastVisit = nil
        self.hours = nil
        self.specificities = nil
    }
    
    func saveToDisk(data: Data) {
        let fileManager = FileManager.default
        
        let urlDocument = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        try? data.write(to: urlDocument!)
        
    }
    
    //func loadFromDisk() -> Data? {
        //let fileManager = FileManager()
        
        //guard var URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask) else {
            // FIXME
        //    return
        //}
    //}
    
}
