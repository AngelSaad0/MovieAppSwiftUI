//
//  MainTabBarView.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//

import SwiftUI

struct MainTabBarView: View {

    var body: some View {
        TabView {
            NavigationView {
                HomeView()
                    .navigationTitle("Home")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }

            NavigationView {
                UpComingView()
                    .navigationTitle("Coming Soon")
            }
            .tabItem {
                Image(systemName: "play.circle")
                Text("Coming Soon")
            }

            NavigationView {
                SearchView()
                    .navigationTitle("Top Search")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Top Search")
            }

            NavigationView {
                DownloadsView()
                    .navigationTitle("Downloads")
            }
            .tabItem {
                Image(systemName: "arrow.down.to.line")
                Text("Downloads")
            }
        }
        .accentColor(.primary)
    }
}




#Preview {
    MainTabBarView()
}
