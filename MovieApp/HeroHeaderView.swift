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
    let constantWidth = UIScreen.main.bounds.width - 32 /* *0.9 */
    @State private var posterPath:String?

    var body: some View {
        ZStack {
            if let posterPath = posterPath {
                let fullPath = baseImageUrl + posterPath

                AsyncImage(url: URL(string:fullPath)) { image in
                    ZStack {
                        image.resizable().aspectRatio(contentMode: .fill)
//                            .frame(maxWidth:.infinity)
                            .frame(width: constantWidth, height: constantWidth * 1.5)
                            .cornerRadius(8)
//                        VStack(spacing:20){
//                            Spacer()

//                            HStack(spacing:30) {
//                                Text("Play")
//                                    .frame(width: 120, height: 35)
//                                    .overlay{
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .stroke(Color("#BD4925"),lineWidth:2)
//                                    }
//                                    .background(.gray.opacity(0.4))
//
//                                Text("DowLoad")
//                                    .frame(width: 120, height: 35)
//
//                                    .overlay{
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .stroke(Color("#BD4925"),lineWidth:2)
//
//                                    }
//                                    .background(.gray.opacity(0.4))
//                            }
//
//                            .foregroundColor(.white)
//                            .font(.title2)
//                        }
//                        .padding(.bottom,15)




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
