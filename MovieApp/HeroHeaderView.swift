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
    let constantWidth = UIScreen.main.bounds.width*0.8
    @State private var movieList:[Movie]?

    var body: some View {
        ZStack {
            if let movieList = movieList {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal) {
                        LazyHStack (spacing:10){
                            ForEach(movieList.indices,id:\.self) { index in
                                let url = movieList[index].posterPath
                                let fullPath = baseImageUrl + (url ?? "")
                                AsyncImage(url: URL(string:fullPath)) { image in
                                    ZStack {
                                        image.resizable().aspectRatio(contentMode: .fit)
                                            .frame(width: constantWidth ,height: constantWidth*1.5)
                                            .cornerRadius(8)
                                        VStack(spacing:20){
                                            Spacer()

                                            HStack(spacing:30) {
                                                Text("Play")
                                                    .frame(width: 120, height: 35)
                                                    .overlay{
                                                        RoundedRectangle(cornerRadius: 8)
                                                            .stroke(Color("#BD4925"),lineWidth:2)
                                                    }
                                                    .background(.gray.opacity(0.4))

                                                Text("DowLoad")
                                                    .frame(width: 120, height: 35)

                                                    .overlay{
                                                        RoundedRectangle(cornerRadius: 8)
                                                            .stroke(Color("#BD4925"),lineWidth:2)

                                                    }
                                                    .background(.gray.opacity(0.4))

                                            }

                                            .foregroundColor(.white)
                                            .font(.title2)
                                        }
                                        .padding(.bottom,15)




                                    }

                                } placeholder: {
                                    ProgressView("Loading...")
                                        .frame(width: constantWidth ,height: constantWidth*1.5)
                                }
                                .id(index)
                            }
                        }
                        .padding(.horizontal)

                    }
                    .onAppear{
                        startAutoScroll(proxy: proxy)
                    }
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
            movieList = movies?.results
        }
    }
    private func startAutoScroll(proxy: ScrollViewProxy) {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                // Scroll to the current index
                proxy.scrollTo(currentIndex, anchor: .center)
                // Update the index for the next scroll
                currentIndex = (currentIndex + 1) % (movieList?.count ?? 1)
            }
        }
    }
    private func startAutoScroll() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % (movieList?.count ?? 1)
            }
        }
    }
}
