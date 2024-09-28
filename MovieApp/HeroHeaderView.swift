//
//  HeroView.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//

import SwiftUI
struct HeroHeaderView: View {
    private var networkManager = NetworkManager()
    @State private var currentIndex = 0
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    let constantWidth = UIScreen.main.bounds.width - 32
    @State private var posterPath:String?

    var body: some View {
        ZStack {
            if let posterPath = posterPath {
                let fullPath = baseImageUrl + posterPath

                AsyncImage(url: URL(string:fullPath)) { image in
                    ZStack {
                        image.resizable().aspectRatio(contentMode: .fill)
                            .frame(width: constantWidth, height: constantWidth * 1.5)
                            .cornerRadius(8)
                    }

                } placeholder: {
                    ProgressView("Loading...")
                        .frame(width: constantWidth ,height: constantWidth*1.5)
                }



            } else {
                ProgressView("Loading Movies...")
            }
        }
        .onAppear {
            fetchMovies()

        }

    }
    private func fetchMovies() {

        networkManager.fetchData(from: .trendingMovie, responseType: Movies.self) { movies in
            posterPath = movies?.results.randomElement()?.posterPath
        }

    }
}
