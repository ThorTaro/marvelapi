//
//  AppDelegate.swift
//  marvelapi
//
//  Created by Taro on 2018/12/17.
//  Copyright © 2018 Taro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let viewController = SearchViewController()
    var navigationController:UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = UINavigationController(rootViewController:viewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}

