//
//  AppDelegate.swift
//  Metallum
//
//  Created by AppleTree on 3/3/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont(name: "Bradley Hand", size: 20)!], forState: UIControlState.Normal)
        
        return true
    }

}

