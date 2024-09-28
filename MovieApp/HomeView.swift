//
//  HomeView.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//

import SwiftUI

struct HomeView: View {

    let sectionTitles: [String] = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top Rated"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    HeroHeaderView()
                        .frame(height: 300)
                    ForEach(sectionTitles.indices, id: \.self) { index in
                        SectionView(sectionTitle: sectionTitles[index], sectionType: sections(rawValue: index)!)
                    }
                }
            }
            .navigationBarItems(
                leading: Image("netflixLogo").resizable().frame(width: 40, height: 40),
                trailing: HStack {
                    Button(action: { }) {
                        Image(systemName: "person").font(.title2)
                    }
                    Button(action: { }) {
                        Image(systemName: "play.rectangle").font(.title2)
                    }
                }
            )
        }
    }
}

struct HeroHeaderView: View {
    @State private var titleViewModel: TitleViewModel? = nil

    var body: some View {
        ZStack {
            if let viewModel = titleViewModel {
                AsyncImage(url: URL(string: viewModel.postURL)) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
            } else {
                Color.gray
            }
        }
        .onAppear {
            // Fetch hero header data
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    let selectedTitle = titles.randomElement()
                    titleViewModel = TitleViewModel(postURL: selectedTitle?.poster_path ?? "", titleName: selectedTitle?.original_title ?? "")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct SectionView: View {
    var sectionTitle: String
    var sectionType: sections

    @State private var titles: [Title] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text(sectionTitle)
                .font(.system(size: 18, weight: .semibold))
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(titles, id: \.id) { title in
                        NavigationLink(destination: TitlePreviewView(viewModel: TitlePreviewViewModel(titleName: title.original_title, postURL: title.poster_path))) {
                            MoviePosterView(title: title)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            loadSectionData()
        }
    }

    func loadSectionData() {
        switch sectionType {
        case .TrendingMovies:
            APICaller.shared.getTrendingMovies { result in
                if case .success(let titles) = result {
                    self.titles = titles
                }
            }
        case .TrendingTv:
            APICaller.shared.getTrendingTV { result in
                if case .success(let titles) = result {
                    self.titles = titles
                }
            }
        case .popular:
            APICaller.shared.GetPopularMovies { result in
                if case .success(let titles) = result {
                    self.titles = titles
                }
            }
        case .UpcomingMovies:
            APICaller.shared.GetUpComingMovies { result in
                if case .success(let titles) = result {
                    self.titles = titles
                }
            }
        case .TopRated:
            APICaller.shared.GetTopRatedMovies { result in
                if case .success(let titles) = result {
                    self.titles = titles
                }
            }
        }
    }
}

struct MoviePosterView: View {
    let title: Title

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: title.poster_path)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Color.gray
            }
            .frame(width: 100, height: 150)
            .cornerRadius(8)
        }
    }
}

struct TitlePreviewView: View {
    let viewModel: TitlePreviewViewModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.postURL)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Color.gray
            }
            Text(viewModel.titleName)
                .font(.largeTitle)
        }
        .navigationTitle(viewModel.titleName)
    }
}

// Dummy Models and API Caller
struct Title: Identifiable {
    let id = UUID()
    let original_title: String
    let poster_path: String
}

struct TitleViewModel {
    let postURL: String
    let titleName: String
}

struct TitlePreviewViewModel {
    let titleName: String
    let postURL: String
}

enum sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case popular = 2
    case UpcomingMovies = 3
    case TopRated = 4
}

// Replace this with real API calls
class APICaller {
    static let shared = APICaller()

    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        completion(.success([Title(original_title: "Movie 1", poster_path: "https://via.placeholder.com/100"),
                             Title(original_title: "Movie 2", poster_path: "https://via.placeholder.com/100")]))
    }

    func getTrendingTV(completion: @escaping (Result<[Title], Error>) -> Void) {
        completion(.success([Title(original_title: "TV Show 1", poster_path: "https://via.placeholder.com/100")]))
    }

    func GetPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        completion(.success([Title(original_title: "Popular Movie", poster_path: "https://via.placeholder.com/100")]))
    }

    func GetUpComingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        completion(.success([Title(original_title: "Upcoming Movie", poster_path: "https://via.placeholder.com/100")]))
    }

    func GetTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        completion(.success([Title(original_title: "Top Rated Movie", poster_path: "https://via.placeholder.com/100")]))
    }
}


#Preview {
    HomeView()
}
