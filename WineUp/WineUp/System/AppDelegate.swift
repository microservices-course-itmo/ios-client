//
//  AppDelegate.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 31.10.2020.
//

import UIKit
import Firebase
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        FirebaseApp.configure()
        registerForPushNotifications()

        return true
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(.noData)
            return
        }
        // This notification is not auth related, developer should handle it.
        handleNotification(notification)
    }

    private func handleNotification(_ notification: [AnyHashable: Any]) {}

    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in

            print("Permission granted: \(granted)")
            guard granted else { return }

            self.getNotificationSettings()
        }
    }

    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }

            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }

        let token = tokenParts.joined()

        UserDefaults.standard.set("Device Token: \(token)", forKey: "APNSID")
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }

}
