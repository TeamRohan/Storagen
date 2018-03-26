//
//  Property.swift
//  Storagen
//
//  Created by Kyle Ohanian on 3/24/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import Foundation

class Property {
    var propertyId: String
    var propertyAddress: String
    var propertySize: String
    var propertyDescription: String
    var imageUrl: URL
    
    init(propertyAddress: String, propertySize: String,
         propertyDescription: String, imageUrl: String) {
        self.propertyId = ""
        self.propertyAddress = propertyAddress
        self.propertySize = propertySize
        self.propertyDescription = propertyDescription
        self.imageUrl = URL(string: imageUrl)!
    }
    
    init(propertyId: Any, dictionary: [String: Any]) {
        self.propertyId = propertyId as! String
        self.propertyAddress = dictionary["propertyAddress"] as! String
        self.propertySize = dictionary["propertySize"] as! String
        self.propertyDescription = dictionary["propertyDescription"] as! String
        self.imageUrl = URL(string: dictionary["imageUrl"] as! String)!
    }
    
    func toString() -> String {
        return "\(propertyAddress), \(propertySize), \(propertyDescription), \(imageUrl)"
    }
}
