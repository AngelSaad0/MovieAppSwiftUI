//
//  HomeView.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//

import SwiftUI

struct HomeView: View {
    @State private var movies: [Movie] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    let sectionTitles: [String] = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top Rated"]

    var body: some View {
        NavigationView {
            ScrollView {
                if  isLoading {
                    ProgressView("Loading...")
                }else if let errorMessage = errorMessage{
                    Text(errorMessage)
                }
                else {
                    VStack(spacing: 20) {
                        HeroHeaderView()
                        MostView(movieEndPoint: .trendingTV, title: "Trending TV Shows")
                        MostView(movieEndPoint: .trendingMovie, title: "Trending Movies")
                        MostView(movieEndPoint: .topRated, title: "Top Rated Movies")
                        MostView(movieEndPoint: .upcoming, title: "Upcoming Movies")
                        MostView(movieEndPoint: .popular, title: "Popular Movies")
                        MostView(movieEndPoint: .now_playing, title: "Now Playing Movies")


                    }

                }

            }
            .navigationTitle("Home")
            .navigationBarItems(
                leading: Image(.pngegg).resizable().frame(width: 40, height: 40),
                trailing: HStack {
                    Button(action: { }) {
                        Image(systemName: "person").font(.title2)
                            .foregroundColor(.red.opacity(0.6))
                    }
                    Button(action: { }) {
                        Image(systemName: "play.rectangle").font(.title2)
                            .foregroundColor(.red.opacity(0.6))
                    }
                }
            )
        }
        .tint(.red)
    }
}



#Preview {
    HomeView()
}
