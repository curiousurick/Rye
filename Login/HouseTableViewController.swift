//
//  HouseTbaleTableViewController.swift
//  Login
//
//  Created by Jason Kwok on 2/8/15.
//  Copyright (c) 2015 Jason Kwok. All rights reserved.
//

import UIKit
import Parse

class HouseTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var houses: [House] = []
    
    var zip: Int?
    var answerToIncome: Int?
    var answerToRent: Int?
    var answerToDown: Int?
    var answerToFamilySize: Int?
    var answerToFirstTime: Bool?
    
    func setInfo(zip: Int, income: Int, rent: Int, down: Int, size: Int, firstTime: Bool) {
        self.zip = zip
        self.answerToIncome = income
        self.answerToRent = rent
        self.answerToDown = down
        self.answerToFamilySize = size
        self.answerToFirstTime = firstTime
        
    }
    override func viewWillAppear(animated: Bool) {
        //houses = [House]()
        FindHouses(zip!, income: answerToIncome!, familySize: answerToFamilySize!, firstTime: answerToFirstTime!, rent: answerToRent!, downPayment: answerToDown!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 10
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as HouseTableViewCell

        var currentHouse: House = self.houses[indexPath.row]
        cell.programName!.text = currentHouse.type.rawValue
        cell.address!.text = currentHouse.address
        
        
        
        
        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func GetHouses(program: ProgramNames){
        var query = PFQuery(className: "HackHousingData")
        var mf_houses = [House]()
        var data_source: String = ""
        
        if program == ProgramNames.MFH {
            data_source = "MultiFamily"
        }
        
        if program == ProgramNames.PH {
            data_source = "PublicHousing"
        }
        
        query.whereKey("DataSource", equalTo: "PublicHousing")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("HEY HOUSES IS BACK WITH \(objects.count)");
                for object in objects {
                    var address = object["Address"] as String
                    var coordinates = Coordinates(lat: 0, long: 0)
                    //var price = object["Value"] as Int
                    //var details = object["Details"] as String
                    var type : ProgramNames = ProgramNames.MFH
                    var house: House = House(coordinates: coordinates, address: address, price: 45000, type: type, details: "Cool house")
                    mf_houses.append(house)
                    
                   
                }
                self.houses = mf_houses
                self.tableView.reloadData()
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
    }
    
    func Evaluator(income: Int, rent:Int, downPayment: Int, family_size: Int, first_time: Bool) -> Void
    {
        
        var query = PFQuery(className: "Evaluator")
        
        var isMfEligible: Bool = false
        query.whereKey("Q_FamilySize", equalTo: family_size)
        query.whereKey("Q_Income1", lessThan: income)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            print(" IF ERROR \(error)");
            println("object count is \(objects.count)");
            
            if error == nil {
                isMfEligible = (objects.count > 0)
                print("YOU ARE ELIGIBLE FOR MFH \(isMfEligible)");
            }
            
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
            
            print("HEY I AM BACK WITH \(eligiblePrograms.count)")
            for program in eligiblePrograms
            {
                print("getting houses for program \(program.rawValue)")
                self.GetHouses(program);
            }
        }
    }
    
    func FindHouses(zipcode: Int, income: Int, familySize: Int, firstTime: Bool, rent: Int, downPayment: Int) ->  Void {
        
        // RUN evaluator and get eligible programs
       Evaluator(income, rent: rent, downPayment: downPayment, family_size: familySize, first_time: firstTime)
    }
}
