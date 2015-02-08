//
//  ViewController.swift
//  Login
//
//  Created by Jason Kwok on 2/7/15.
//  Copyright (c) 2015 Jason Kwok. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var located: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet var zipTextField: UITextField!
    
    @IBAction func ContinueButtonClicked(sender: AnyObject) {
        var text = zipTextField.text
        var count = countElements(text)
        if(count == 5){
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBar") as UITabBarController
            
            self.presentViewController(viewController, animated: true, completion: nil)
            var navBar: UINavigationController = viewController.viewControllers?.first as UINavigationController
            var mainVC: MainViewController = navBar.topViewController as MainViewController
            println("this was callled")
            mainVC.setZip(text)
        }
        else {
            var ErrorAlert = UIAlertView()
            ErrorAlert.title = "Something went wrong!"
            ErrorAlert.message = "Please enter your zip code!"
            ErrorAlert.delegate = self
            ErrorAlert.addButtonWithTitle("OK")
            ErrorAlert.show()
        }

        
    }

    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        let prospectiveText = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if textField == zipTextField {
            if countElements(string) > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.-").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                
                let resultingStringLengthIsLegal = countElements(prospectiveText) <= 5
                
                result = replacementStringIsLegal &&
                resultingStringLengthIsLegal
            }
        }
        return result
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        zipTextField.delegate = self
        addDoneButtonOnKeyboard()
        located.layer.masksToBounds = true
        located.layer.cornerRadius = 10
        continueButton.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 10
        
        
        // Do any additional setup after loading the view, typically from a nib.
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
        
        //self.zipTextField.inputAccessoryView = doneToolbar
        self.zipTextField.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToLand(segue:UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "toTabBar") {
////            var text:String = zipTextField.text
////            var count: Int = countElements(text)
////            if(count == 5) {
////            var tabBar : UITabBarController = segue.destinationViewController as UITabBarController
////            var navBar: UINavigationController = tabBar.viewControllers?.first as UINavigationController
////            var mainVC: MainViewController = navBar.topViewController as MainViewController
////            println("this was callled")
////            mainVC.setZip(text)
////            }
////        }
    }
}

