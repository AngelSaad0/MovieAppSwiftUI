//
//  MostView.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//
import SwiftUI
struct MostView:View {
    let movieEndPoint:MovieApi
    let title: String
    var networkManager = NetworkManager()
    @State private var currentIndex = 0
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    let constantWidth = UIScreen.main.bounds.width*0.4
    @State private var movieList:[Movie]?

    var body: some View {
        ZStack {
            if let movieList = movieList {
                VStack {
                    HStack {
                        Text(title)
                            .font(.title2.bold())
                            .padding(.bottom, 10)
                            .padding(.top, 30)
                        Spacer()
                    }
                    .padding(.horizontal)
                    ScrollView(.horizontal) {
                        LazyHStack (spacing:10){
                            ForEach(movieList.indices,id:\.self) { index in
                                let url = movieList[index].posterPath
                                let fullPath = baseImageUrl + url!
                                AsyncImage(url: URL(string:fullPath)) { image in
                                    ZStack {
                                        image.resizable().aspectRatio(contentMode: .fit)
                                            .frame(width: constantWidth ,height: constantWidth*1.5)
                                            .cornerRadius(8)
                                        
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
                    }
                }


            } else {
                ProgressView("Loading Movies...")
            }
        }
        .onAppear {
            fetchMovies(endPoint:movieEndPoint)

        }

    }
    private func fetchMovies( endPoint:MovieApi) {
        networkManager.fetchData(from: endPoint, responseType: Movies.self) { movies in
            movieList = movies?.results
        }
    }
}

#Preview {
    MostView(movieEndPoint: .popular, title: "Popular Movies")
}
