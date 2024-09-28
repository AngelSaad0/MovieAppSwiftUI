//
//  MovieApi.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//

import Foundation
enum MovieApi {
    private static let baseUrl = "https://api.themoviedb.org/3/"
    private static let moviePath = "movie/"
    private static let apiKey = "30dafbee1b24fdef15b88ce161deecc2"

    case now_playing
    case popular
    case upcoming
    case topRated
    case trendingTV
    case trendingMovie
    case details(id:Int)
    private var path: String {
        switch self {
        case .now_playing:
            return "now_playing"
        case .popular:
            return "popular"
        case .upcoming:
            return "upcoming"
        case .details(let id):
            return "\(id)"
        case .topRated:
            return "top_rated"
        case .trendingMovie:
            return "trending/movie/week"
        case .trendingTV:
            return "trending/tv/week"
        }
    }
    private var endpoint: String {
            switch self {
            case .trendingMovie,.trendingTV:
                return ""
            default:
                return MovieApi.moviePath
            }
        }
    var urlString: String {
        return "\(MovieApi.baseUrl)\(endpoint)\(path)?api_key=\(MovieApi.apiKey)"

        }
}

