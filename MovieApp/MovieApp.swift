////
////  MovieApp.swift
////  MovieApp
////
////  Created by Engy on 9/26/24.
////
//
//import UIKit
//import GoogleSignIn
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    var userData = UserData()
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        GIDSignIn.sharedInstance.restorePreviousSignIn(callback: { user, error in
//            if error != nil || user == nil {
//                // Show the app's signed-out state.
//                print("Not sign-in")
//            }
//            else {
//                // Show the app's signed-in state.
//                if let user=user, let userID = user.userID {
//                    self.userData.signIn(user: user)
//                    print("Already signed-in as :\(userID)")
//                }
//            }
//        })
//
//
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//
//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey:Any] = [:]) -> Bool {
//        var handled: Bool
//
//        handled = GIDSignIn.sharedInstance.handle(url)
//        if handled {
//            return true
//        }
//
//        return false
//    }
//}
//


//
//  MovieApp.swift
//  MovieApp
//
//  Created by Engy on 9/26/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MovieApp: App {
    @StateObject var userData = UserData()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(userData)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        if let user = user {
                            userData.signIn(user: user)
                            print("Already signed in as: \(user.userID)")
                        } else {
                            print("Not signed in")
                        }
                    }
                }
        }
    }
}

