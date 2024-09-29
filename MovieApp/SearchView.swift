//
//  SearchView.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//
import SwiftUI

struct SearchView: View {
    @State private var movieList: [Movie]?
    @State private var isLoading: Bool = true
    @State private var searchTerm: String = ""
    var networkManager = NetworkManager()
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"

    var filteredMovies: [Movie] {
        if let movieList = movieList {
            if searchTerm.trimmingCharacters(in: .whitespaces).isEmpty {
                return movieList
            } else {
                return movieList.filter { $0.title?.lowercased().contains(searchTerm.lowercased().trimmingCharacters(in: .whitespaces)) ?? false }
            }
        }
        return []
    }

    var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    ProgressView("Loading Movies...")
                } else {
                    List(filteredMovies.indices, id: \.self) { index in
                        let url = filteredMovies[index].posterPath ?? ""
                        let fullPath = baseImageUrl + url

                        NavigationLink(destination: MovieDetailsView(movieID: filteredMovies[index].id, isMovie: true)) {
                            HStack(spacing: 16) {
                                AsyncImage(url: URL(string: fullPath)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 120)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 80, height: 120)
                                }

                                VStack(alignment: .leading, spacing: 8) {
                                    Text(filteredMovies[index].title ?? "Unknown Title")
                                        .font(.headline)
                                    Text(filteredMovies[index].releaseDate ?? "N/A")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle()) 
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchTerm, prompt: "Search movies")
            .onAppear {
                fetchUpcomingMovies()
            }
        }
        .tint(.red)
    }

    private func fetchUpcomingMovies() {
        let upcomingEndpoint: MovieApi = .upcoming
        networkManager.fetchData(from: upcomingEndpoint, responseType: Movies.self) { movies in
            movieList = movies?.results
            isLoading = false
        }
    }
}

#Preview {
    SearchView()
}
