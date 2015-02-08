//
//  MainViewController.swift
//  Login
//
//  Created by Jason Kwok on 2/7/15.
//  Copyright (c) 2015 Jason Kwok. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    var zip: Int?
    
    var answerToIncome: Int?
    var answerToRent: Int?
    var answerToDown: Int?
    var answerToFamilySize: Int?
    var answerToFirstTime: Bool?
    
    @IBOutlet weak var income: UITextField!
    @IBOutlet weak var rent: UITextField!
    @IBOutlet weak var downPayment: UITextField!
    @IBOutlet weak var familySize: UITextField!
    @IBOutlet weak var firstTime: UISwitch!
    
    @IBAction func SubmitButtonClicked(sender: UIButton) {
        if(income.text != "" && rent.text != "" && downPayment.text != "" && familySize.text != "") {
        answerToIncome = income.text.toInt()
        answerToRent = rent.text.toInt()
        answerToDown = downPayment.text.toInt()
        answerToFamilySize = familySize.text.toInt()
        answerToFirstTime = firstTime.on
            if(zip == nil) {
                zip = 98052
            }
        var houseVC = HouseTableViewController()
            houseVC.setInfo(zip!, income: answerToIncome!, rent: answerToRent!, down: answerToDown!, size: answerToFamilySize!, firstTime: answerToFirstTime!)
        self.navigationController?.pushViewController(houseVC, animated: true)
        //self.performSegueWithIdentifier("toHouseTable", sender: nil)
        println("this was callled")
        }
        else {
            var ErrorAlert = UIAlertView()
            ErrorAlert.title = "Something went wrong!"
            ErrorAlert.message = "Please answer all the questions, please!"
            ErrorAlert.delegate = self
            ErrorAlert.addButtonWithTitle("OK")
            ErrorAlert.show()
        }
        
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "toHouseTable" {
//            if let destinationVC = segue.destinationViewController as? HouseTableViewController{
//                println("This won't get called")
//                destinationVC.setInfo(zip!, income: answerToIncome!, rent: answerToRent!, down: answerToDown!, size: answerToFamilySize!, firstTime: answerToFirstTime!)
//                
//            }
//        }
//    }
    
    
//    @IBOutlet var scrollView: UIScrollView!
//    @IBOutlet var pageControl: UIPageControl!
//    @IBOutlet var question: UILabel!
//    @IBOutlet var input: UITextField!
//    @IBOutlet var submitButton: UIButton!
//    
//    var questionStrings: [String] = []
//    var pageViews: [UIView?] = []
//    var answerStrings: [Int] = []
//    var buttonString: [String] = []
//    var buttonsAnswered: [Bool] = []
//    
    
   // @IBOutlet var label: UILabel!
    func setZip(zip: String) {
        self.zip = zip.toInt()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
        income.delegate = self
        rent.delegate = self
        downPayment.delegate = self
        familySize.delegate = self
        
//        questionStrings = ["How much does your family make per year?", "How much are you currently paying for rent each month?", "How much can you afford to put down on a house?", "How many people are in your family?", "Are you buying a home for the first time?"]
//        let pageCount = questionStrings.count
//        
//        pageControl.currentPage = 0
//        pageControl.numberOfPages = pageCount
//        
//        for _ in 0..<pageCount {
//            pageViews.append(nil)
//        }
//        
//        let pagesScrollViewSize = scrollView.frame.size
//        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(questionStrings.count), height: pagesScrollViewSize.height)
//        
      //  loadVisiblePages()
        
        
        
       // label.text = zip

        // Do any additional setup after loading the view.
    }
    
//    func loadPage(page: Int) {
//        if page < 0 || page >= questionStrings.count {
//        return
//        }
//        
//        //if let pageView = questionStrings[page] {
//            
//        } else {
//            var frame = scrollView.bounds
//            frame.origin.x = frame.size.width * CGFloat(page)
//            frame.origin.y = 0.0
//            
//            
//           // let newPageView = UIView(
//        }
//    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        let prospectiveText = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if textField == income || textField == rent || textField == downPayment {
            if countElements(string) > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.-").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                
                let resultingStringLengthIsLegal = countElements(prospectiveText) <= 7
                
                result = replacementStringIsLegal &&
                resultingStringLengthIsLegal
            }
        }
        else if textField == familySize {
            if countElements(string) > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.-").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                
                let resultingStringLengthIsLegal = countElements(prospectiveText) <= 2
                
                result = replacementStringIsLegal &&
                resultingStringLengthIsLegal
            }
        }
        return result
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
        
        self.income.inputAccessoryView = doneToolbar
        self.rent.inputAccessoryView = doneToolbar
        self.downPayment.inputAccessoryView = doneToolbar
        self.familySize.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.view.endEditing(true)
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
