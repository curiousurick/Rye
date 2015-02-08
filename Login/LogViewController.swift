//
//  LoginViewController.swift
//  Login
//
//  Created by Jason Kwok on 2/7/15.
//  Copyright (c) 2015 Jason Kwok. All rights reserved.
//

import UIKit
import Parse

class LogViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    func checkInput() -> Bool{
        var u = setUsername(Email.text)
        var p = setPassword(Password.text)
        
        var ErrorAlert: UIAlertView = UIAlertView()
        var isGood: Bool
        
        if u == "Good" && p == "Good" {
            isGood = true
            
            
        }
        
        else {
            if u == "Bad" {
            ErrorAlert.title = "Invalid Email! 😫"
            ErrorAlert.message = "Please enter a valid email address"
            isGood = false
            }
            else if p == "Short" {
            ErrorAlert.title = "Too Short! 😫"
            ErrorAlert.message = "Password requires 8 or more characters."
            isGood = false
            }
            else if p == "Letters" {
            ErrorAlert.title = "No Letters! 😫"
            ErrorAlert.message = "Password requires a letter."
            isGood = false
            }
            else if p == "Numbers" {
            ErrorAlert.title = "No Numbers! 😫"
            ErrorAlert.message = "Password requires a number."
            isGood = false
            }
            else {
                ErrorAlert.title = "I have no idea what happened"
                ErrorAlert.message = "I guess try again?"
                isGood = false
            }
            
            ErrorAlert.delegate = self
            ErrorAlert.addButtonWithTitle("OK")
            ErrorAlert.show()
        }
        
        return isGood
        
    }

    
    @IBAction func loginButtonClicked(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(Email.text, password:Password.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                let viewContoler = self.storyboard?.instantiateViewControllerWithIdentifier("TabBar") as UITabBarController
                self.presentViewController(viewContoler, animated: true, completion: nil)
               // NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loggedIn")
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    @IBAction func facebookButtonClicked(sender: AnyObject) {
        var permissions = ["email"]
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                let viewContoler = self.storyboard?.instantiateViewControllerWithIdentifier("TabBar") as UITabBarController
                self.presentViewController(viewContoler, animated: true, completion: nil)
                // NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loggedIn")

            } else {
                NSLog("User logged in through Facebook!")
                let viewContoler = self.storyboard?.instantiateViewControllerWithIdentifier("TabBar") as UITabBarController
                self.presentViewController(viewContoler, animated: true, completion: nil)
                //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loggedIn")

            }
        })
        
        
    }
    @IBAction func signupButtonClicked(sender: AnyObject) {
        var user = PFUser()
        
        if(checkInput()) {
            user.username = Email.text
            user.password = Password.text
            user.email = Email.text
        // other fields can be set just like with PFObject
        
        var ErrorAlert: UIAlertView = UIAlertView()
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool!, error: NSError!) -> Void in
                if error == nil {
                    let viewContoler = self.storyboard?.instantiateViewControllerWithIdentifier("TabBar") as UITabBarController
                    self.presentViewController(viewContoler, animated: true, completion: nil)
                   // NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loggedIn")
                    //self.performSegueWithIdentifier("main", sender: nil)
                    
                    // Hooray! Let them use the app now.
                } else {
                    ErrorAlert.title = "You already have an account!"
                    ErrorAlert.message = "Try signing in!"
                    // Show the errorString somewhere and let the user try again.
                    ErrorAlert.delegate = self
                    ErrorAlert.addButtonWithTitle("OK")
                    ErrorAlert.show()
                }
            }
            
        }
        
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func setUsername(newValue: String) -> String {
        var hasAt: Bool = false
        var hasDot: Bool = false
        
        for letter in newValue {
            
            if letter == "@" {
                hasAt = true
            }
            
            if letter == "." {
                hasDot = true
            }
        }
        
        if hasAt && hasDot {
            return "Good"
        } else {
            return "Bad"
        }
    }
    func addDoneButtonOnKeyboard()
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
        
        var items = NSMutableArray()
        items.addObject(flexSpace)
        items.addObject(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.Email.inputAccessoryView = doneToolbar
        self.Password.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    func setPassword(newValue: String) -> String {
        let letters = NSCharacterSet.letterCharacterSet()
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        
        //Password Constraint Variables
        var hasLetters: Bool = false
        var hasNumb: Bool = false
        let length = countElements(newValue)
        
        //Check Password Constraints
        for letter in newValue.unicodeScalars {
            
            if letters.longCharacterIsMember(letter.value) {
                hasLetters = true
            }
            
            if digits.longCharacterIsMember(letter.value) {
                hasNumb = true
            }
        }
        
        if length >= 8 && hasLetters && hasNumb {
            return "Good"
        }
        else if length < 8 {
            return "Short"
        }
        else if !hasLetters {
            return "Letters"
        }
        else {
            return "Numbers"
        }
    }

    
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Email.delegate = self
        Password.delegate = self
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 10
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = 10
        facebookButton.layer.masksToBounds = true
        facebookButton.layer.cornerRadius = 10
        signupButton.layer.masksToBounds = true
        signupButton.layer.cornerRadius = 10
        addDoneButtonOnKeyboard()
        
        
        // Do any additional setup after loading the view.
    }
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        
    }
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        
    }
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == self.Email) {
            self.Password.becomeFirstResponder()
        }
        else if(textField == self.Password) {
            self.loginButtonClicked(loginButton)
        }
        return true
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
