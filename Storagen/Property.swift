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
    var propertyOwnerId: String
    var propertyAddress: String
    var propertySize: String
    var propertyDescription: String
    var propertyImageUrl: URL?
    var propertyStartDate: String
    var propertyEndDate: String
    var propertyPrice: String
    var propertyLatitude: String
    var propertyLongitude: String
    
    init(propertyAddress: String, propertySize: String,
         propertyDescription: String, imageUrl: String) {
        self.propertyId = ""
        self.propertyOwnerId = ""
        self.propertyAddress = propertyAddress
        self.propertySize = propertySize
        self.propertyDescription = propertyDescription
        self.propertyImageUrl = URL(string: imageUrl)!
        self.propertyStartDate = ""
        self.propertyEndDate = propertyStartDate
        self.propertyPrice = ""
        self.propertyLatitude = "1.0"
        self.propertyLongitude = "1.0"
    }
    
    init(propertyId: Any, dictionary: [String: Any]) {
        self.propertyId = propertyId as! String
        self.propertyOwnerId = dictionary["userId"] as! String
        self.propertyAddress = dictionary["address"] as! String
        self.propertySize = dictionary["size"] as! String
        self.propertyDescription = dictionary["description"] as! String
        self.propertyImageUrl = URL(string: dictionary["imageUrl"] as! String)!
        self.propertyStartDate = dictionary["startDate"] as! String
        self.propertyEndDate = dictionary["endDate"] as! String
        self.propertyPrice = dictionary["price"] as! String
        self.propertyLatitude = dictionary["latitude"] as! String
        self.propertyLongitude = dictionary["longitude"] as! String
        
    }
    
    func toString() -> String {
        return "\(propertyAddress), \(propertySize), \(propertyDescription), \(propertyImageUrl)"
    }
}
