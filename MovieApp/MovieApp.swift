
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
    @AppStorage("continueAsAGuest") var continueAsAGuest: Bool = false
    @AppStorage("isLogin") var isLogin: Bool = false

    @StateObject var userData = UserData()

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            contentView()
                .environmentObject(userData)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        if let user = user {
                            userData.signIn(user: user)
                            print("Already signed in as: \(String(describing: user.userID))")
                        } else {
                            print("Not signed in")
                        }
                    }
                }
        }
    }

    @ViewBuilder
    func contentView() -> some View {
            if continueAsAGuest || isLogin {
                MainTabBarView() // Your main view for logged-in users
            } else {
                LoginView() // Show login options if not logged in
            }

    }
}
