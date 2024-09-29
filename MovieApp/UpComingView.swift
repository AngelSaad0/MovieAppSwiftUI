//
//  UpComingView.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//

import SwiftUI

struct UpComingView: View {
    @State private var movieList: [Movie]?
    @State private var isLoading: Bool = true
    var networkManager = NetworkManager()

    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    let constantWidth = UIScreen.main.bounds.width * 0.4

    // Define the grid layout
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    ProgressView("Loading Movies...")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            if let movieList = movieList {
                                ForEach(movieList.indices, id: \.self) { index in
                                    let url = movieList[index].posterPath ?? ""
                                    let fullPath = baseImageUrl + url

                                    NavigationLink(destination: MovieDetailsView(movieID: movieList[index].id, isMovie: true)) {
                                        AsyncImage(url: URL(string: fullPath)) { image in
                                            ZStack {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .cornerRadius(8)
                                            }
                                        } placeholder: {
                                            ProgressView("Loading...")
                                                .frame(width: constantWidth, height: constantWidth * 1.5)
                                        }
                                        .id(index)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Coming Soon")
            .onAppear {
                fetchUpcomingMovies()
            }
        }
        .tint(.red)
    }

    private func fetchUpcomingMovies() {
        let upcomingEndpoint: MovieApi = .upcoming  // Adjust this to your API
        networkManager.fetchData(from: upcomingEndpoint, responseType: Movies.self) { movies in
            movieList = movies?.results
            isLoading = false
        }
    }
}

#Preview {
    UpComingView()
}
