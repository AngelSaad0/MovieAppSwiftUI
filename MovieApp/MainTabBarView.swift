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
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            UpComingView()
                .tabItem {
                    Label("Coming Soon", systemImage: "play.circle")
                }
            
            SearchView()
                .tabItem {
                    Label("Top Search", systemImage: "magnifyingglass")
                }
            
            DownloadsView()
                .tabItem {
                    Label("Downloads", systemImage: "arrow.down.to.line")
                }
        }
        .accentColor(.primary)
    }
}




#Preview {
    MainTabBarView()
}
