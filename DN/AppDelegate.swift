//
//  AppDelegate.swift
//  ShenSu
//
//  Created by shensu on 17/5/9.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import SwiftyJSON
import EasyPeasy
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var launchScreen: UIImageView?
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window?.frame = UIScreen.main.bounds
        self.window?.rootViewController = GuidanceViewController()
        self.window?.makeKeyAndVisible()
        addPush(application: application, launchOptions: launchOptions)
        // Override point for customization after application launch.
        return true
    }
    func addPush(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        UMessage.start(withAppkey: AppNeedKey().UMkey, launchOptions: launchOptions)
        UMessage.registerForRemoteNotifications()
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            
            center.delegate = self
            
            let typers10: UNAuthorizationOptions = [.badge, .alert, .sound]
            center.requestAuthorization(options: typers10) { (granted, error) in
                if granted {
                } else {
                    
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
 

   
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        UMessage.didReceiveRemoteNotification(userInfo)
    
        completionHandler(.newData)
    }
  

    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userinfo = notification.request.content.userInfo
        
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            UMessage.setAutoAlert(true)
            UMessage.didReceiveRemoteNotification(userinfo)
        } else {
        }
        
        completionHandler([.sound, .badge, .alert])
    }

    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userinfo = response.notification.request.content.userInfo
        
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            UMessage.didReceiveRemoteNotification(userinfo)
        } else {
        }
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}
