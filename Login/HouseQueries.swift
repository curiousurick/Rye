//
//  HouseQueries.swift
//  Login
//
//  Created by George Urick on 2/8/15.
//  Copyright (c) 2015 Jason Kwok. All rights reserved.
//

import Foundation
import Parse


class HouseQuery {
    class func GetHouses(program: ProgramNames, reloading: () -> Void) -> Array<House> {
        var query = PFQuery(className: "HackHousing")
        var mf_houses = [House]()
        var data_source: String = ""
        
        if program == ProgramNames.MFH {
            data_source = "MultiFamily"
        }
        
        if program == ProgramNames.PH {
            data_source = "PublicHousing"
        }
        
        query.whereKey("DataSource", equalTo: data_source)
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    var address = object["Address"] as String
                    var coordinates = Coordinates(lat: 0, long: 0)
                    var price = object["Value"] as Int
                    var details = object["Details"] as String
                    var type : ProgramNames = ProgramNames.MFH
                    var house: House = House(coordinates: coordinates, address: address, price: price, type: type, details: details)
                    mf_houses.append(house)
                }
            }
        }
        
//        var objectsBlah = query.findObjects()
//        for object in objectsBlah {
//            var address = object["Address"] as String
//            var coordinates = Coordinates(lat: 0, long: 0)
//            var price = object["Value"] as Double
//            var details = object["Details"] as String
//            var type : ProgramNames = ProgramNames.MFH
//            var house: House = House(coordinates: coordinates, address: address, price: price, type: type, details: details)
//            mf_houses.append(house)
//        }

        return mf_houses
    }
    
    
}