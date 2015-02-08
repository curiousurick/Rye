//
//  File.swift
//  Buyr
//
//  Created by George Urick on 2/7/15.
//  Copyright (c) 2015 AHZillow. All rights reserved.
//

import Foundation
import Parse

class House{
    var coordinates:Coordinates
    var address:String
    var price: Int
    var type: ProgramNames
    //var contact: String
    var details: String
    
    init(coordinates: Coordinates, address:String, price: Int, type: ProgramNames, details: String) {
        self.coordinates = coordinates
        self.address = address
        self.price = price
        self.type = type
        //self.contact = contact
        self.details = details
    }
}
