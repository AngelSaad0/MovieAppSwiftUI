//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Engy on 9/26/24.
//

import SwiftUI

@main
struct MovieAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
