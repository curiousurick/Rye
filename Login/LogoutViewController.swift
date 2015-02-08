//
//  LogoutViewController.swift
//  Login
//
//  Created by Jason Kwok on 2/7/15.
//  Copyright (c) 2015 Jason Kwok. All rights reserved.
//

import UIKit
import Parse

class LogoutViewController: UIViewController {

    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
        println("Logged out")
        //var landingVC = LandingViewController()
        //landingVC.present
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "Land") {
            var land: LandingViewController = segue.destinationViewController as LandingViewController
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
