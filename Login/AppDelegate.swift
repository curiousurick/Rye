//
//  AppDelegate.swift
//  Login
//
//  Created by Jason Kwok on 2/7/15.
//  Copyright (c) 2015 Jason Kwok. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        Parse.enableLocalDatastore()
        
        
        Parse.setApplicationId("zCY6tAOZOVCw8mI74mOpKinRsOnII7hkKcXPe5lg", clientKey: "ycyxfYQZAx5lGT6Dajj5FI6DmzJozDPuvqEgzNHc")
        PFFacebookUtils.initializeFacebook()
        
      //  NSUserDefaults.standardUserDefaults()
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil) as UIStoryboard
            let main = storyboard.instantiateViewControllerWithIdentifier("TabBar") as UITabBarController
            self.window?.rootViewController = main
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil) as UIStoryboard
            let land = storyboard.instantiateViewControllerWithIdentifier("Land") as UIViewController
            self.window?.rootViewController = land
        }
        
       
        
//        if NSUserDefaults.standardUserDefaults().boolForKey("loggedIn") == true {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil) as UIStoryboard
//            let main = storyboard.instantiateViewControllerWithIdentifier("TabBar") as UITabBarController
//            self.window?.rootViewController = main
//        }
        

        
        
        
        // Override point for customization after application launch.
        return true
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication,
            withSession:PFFacebookUtils.session())
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

