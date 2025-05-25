//
//  AppDelegate.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 23/5/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = MainTabBarController()
        return true
    }
}
