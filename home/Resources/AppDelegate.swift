//
//  AppDelegate.swift
//  home
//
//  Created by 오연서 on 1/14/24.
//
import UIKit
import FirebaseCore
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        // Request notification permissions
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        
        return true
    }
    
    

    // Handle the registration for remote notifications.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
       
       // Handle received FCM token.
       func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
           if let token = fcmToken {
               print("Firebase Cloud Messaging Token: \(token)")
           } else {
               print("Firebase Cloud Messaging Token is nil.")
           }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        
        // Handle the received remote notification here.
        
        completionHandler(.newData)
    }
    
    // Handle user responses to received notifications.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            // Handle user's response to the notification here.
            completionHandler()
        }
        
        // Handle received notifications while the app is in the foreground.
        @available(iOS 17.0, *)
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
            let userInfo = notification.request.content.userInfo
            print(userInfo)
            
            // Return the desired presentation options for the notification.
            return [.banner, .list, .badge, .sound]
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
    }
    
   
    
}
