//
//  AppDelegate.swift
//  TYUtils
//
//  Created by Olivier Voyer on 01/12/2021.
//  Copyright (c) 2021 Olivier Voyer. All rights reserved.
//

import UIKit
import TYUtils

private extension UserDefault.Key {
    static var isAppFirstInstall: Self { return "isAppFirstInstall" }
}

private extension Keychain.Key {
    static var isAppFirstInstallEver: Self { return "isAppFirstInstallEver" }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    @Keychain(key: .isAppFirstInstallEver,
              withAccess: .accessibleAfterFirstUnlock,
              synchronizable: true,
              keyPrefix: String(describing: AppDelegate.self) + ".")
    var isAppFirstInstallEver: Bool = true

    @UserDefault(key: .isAppFirstInstall)
    var isAppFirstInstall: Bool = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        if isAppFirstInstallEver {
            print("The app is launched for the first time for this user")
        } else {
            print("The app has already been launched for this user on this device or another")
        }

        if isAppFirstInstall {
            print("The app is launched for the first time on this device")
        } else {
            print("The app has already been launched on this device")
        }

        isAppFirstInstallEver = false
        isAppFirstInstall = false

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}
