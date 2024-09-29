//
//  SetRootView.swift
//  MovieApp
//
//  Created by Mohamed Ayman on 29/09/2024.
//

import SwiftUI

func setRootView<Content: View>(rootView: Content, duration: TimeInterval = 0.5, options: UIView.AnimationOptions = .transitionCrossDissolve) {
    guard let window = UIApplication.shared
            .connectedScenes
            .flatMap({ ($0 as? UIWindowScene)?.windows ?? [] })
            .first(where: { $0.isKeyWindow }) else { return }

    UIView.transition(with: window, duration: duration, options: options, animations: {
        window.rootViewController = UIHostingController(rootView: rootView)
    }, completion: { _ in
        window.makeKeyAndVisible()
    })
}
