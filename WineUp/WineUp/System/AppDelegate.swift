//
//  AppDelegate.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 31.10.2020.
//

import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        FirebaseApp.configure()

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
}
