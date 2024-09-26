//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Engy on 9/26/24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Access userData from AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userData = appDelegate.userData

        // Example: Conditional logic to show LoginScreen instead of HomeScreen
//        let contentView: AnyView
//        if true {  // Assuming `isLoggedIn` is a property in userData to check login status
//            contentView = AnyView(SignInScreenView().environmentObject(userData))
//        } else {
//            contentView = AnyView(SignInScreenView().environmentObject(userData))  // Show LoginScreen if not logged in
//        }

        // Set up the window and root view controller
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: SignInScreenView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (e.g., an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Undo the changes made when entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
