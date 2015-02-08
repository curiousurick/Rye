//
//  SampleClient.swift
//  Buyr
//
//  Created by George Urick on 2/7/15.
//  Copyright (c) 2015 AHZillow. All rights reserved.
//

import Foundation
import Parse

internal class DataApiClient {
        
    
//    func GetData(completionHandlerParam:(House?, NSError?) -> Void) ->NSURLSessionTask
//    {
//        //XCPSetExecutionShouldContinueIndefinitely()
//        let urlString = "https://zillowhack.hud.opendata.arcgis.com/datasets/c55eb46fbc3b472cabd0c2a41f805261_0.geojson?where=&geometry={'xmin':-13695603.426866395,'ymin':6018679.182711435,'xmax':-13540283.385390857,'ymax':6064541.399682558,'spatialReference':{'wkid':102100}}"
//    
//        let url: NSURL = NSURL(string:urlString)!
//        
//        let session = NSURLSession.sharedSession();
//        
//        let task = session.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
//            
//            // Web Error
//            if error != nil {
//                // Parse the json into House and give it to CompletionHandlerParam
//                print(error);
//            }
//        
//            // Json Parsing Error
//            var err : NSError?
//            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
//            //print(data)
//            let json = JSON(data: data);
//            //print(json);
//            //print(json["data"]);
//            
//            let  results = jsonResult["features"];
//            
//            print(results)
//            
////            for(key, value) in jsonResult {
////                let keyName = key as String
////                let keyValue : String = value as String
////                
////                print(keyName);
////                print(keyValue);
////            }
//            completionHandlerParam(nil, nil);
//            })
//        
//        task.resume()
//        return task
//    }
    
    func GetMultiFamilyHouses() -> Void
    {
        var query = PFQuery(className:"MFP_FINAL")
        //query.whereKey("objectId", equalTo: "GqkpyPMVZ2")
        var geoPoint = PFGeoPoint(latitude: 47.733786, longitude: -122.621273);
        query.whereKey("GeoPoint2", nearGeoPoint: geoPoint, withinMiles: 100.0)
        query.findObjectsInBackgroundWithBlock
            {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    // Find Succeeded
                    print("Retrieved \(objects.count) properties.")
//                    for object in objects
//                    {
//                        var query1 = PFQuery(className: "MFP_FINAL")
//                        query1.getObjectInBackgroundWithId(object.objectId) {
//                            (objectToUpdate: PFObject!, error: NSError!) -> Void in
//                            if error != nil{
//                                print("DAMN!!!")
//                        }
//                            else {
//                                let lat = object["LATITUDE"] as NSString
//                                print("latitutde is \(lat)")
//                                let long = object["LONGITUDE"] as NSString
//                                print("longitude is \(long)")
//                                var geoPoint : PFGeoPoint = PFGeoPoint(latitude: lat.doubleValue, longitude: long.doubleValue)
//                                objectToUpdate["GeoPoint2"] = geoPoint
//                                objectToUpdate.saveInBackgroundWithBlock {
//                                    (success: Bool, error: NSError!) -> Void in
//                                    if(success) {
//                                        print("Successfully Saved");
//                                    }
//                                    else {
//                                        print(" Hey CANNOT SAVE");
//                                    }
//                                }
//                            }
//                        }
//                    }
                }
                else {
                    print("Faillll!!!!")
                }
        }
    }
    
    class func Evaluator(income: Int, rent:Int, downPayment: Int, family_size: Int, first_time: Bool) -> Array<ProgramNames>
    {
        
        var query = PFQuery(className: "Evaluator")
        
        var isMfEligible: Bool = false
        query.whereKey("Q_FamilySize", equalTo: family_size)
        query.whereKey("Q_Income1", lessThan: income)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                isMfEligible = (objects.count > 0)
            }
        }
        
        query = PFQuery(className: "Evaluator")
        
        var isFMREligible: Bool = income < 32500 // Hard code
        
        var isPHEligible: Bool = income < 52541 // Hard code
        
        
        // Return Programs
        var eligiblePrograms: Array<ProgramNames> = Array<ProgramNames>()
        
        if isFMREligible {
            eligiblePrograms.append(ProgramNames.FMR)
        }
        
        if isPHEligible {
            eligiblePrograms.append(ProgramNames.PH)
        }
        
        if isMfEligible {
            eligiblePrograms.append(ProgramNames.MFH)
        }
        
        return eligiblePrograms
    }
    
//    class func FindHouses(zipcode: Int, income: Int, familySize: Int, firstTime: Bool, rent: Int, downPayment: Int) ->  [House] {
//        
//        // RUN evaluator and get eligible programs
//        var programs: Array<ProgramNames> = Evaluator(income, rent: rent, downPayment: downPayment, family_size: familySize, first_time: firstTime)
//        var housesByPrograms: [House] =  [House]()
//        
//        print("ELIGIBLE FOR \(programs.count) PROGRAM")
//        // get houses for each program
//        for program in programs
//        {
//            print("getting houses for program \(program.rawValue)")
//            var tempHouses = HouseQuery.GetHouses(program);
//            print("Got \(tempHouses.count) houses");
//            housesByPrograms += HouseQuery.GetHouses(program);
//        }
//        
//        print("ELIGIBLE FOR \(housesByPrograms.count) HOUSES")
//        
//        return housesByPrograms;
//    }
    
//    func BuildPFQuery(classNameParam:String, filters:Dictionary<String: String>)->PFQuery
//    {
//        var query = PFQuery(className: classNameParam)
//
//        for(key, value) in filters {
//            query.whereKey(key, equalTo: value)
//        }
//        
//        return query
//    }
}