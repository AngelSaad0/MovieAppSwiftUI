//
//  MovieApi.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//

import Foundation
enum MovieApi {
    private static let baseUrl = "https://api.themoviedb.org/3/movie/"
    private static let apiKey = "30dafbee1b24fdef15b88ce161deecc2"

    case now_playing
    case popular
    case upcoming
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
        }
    }
    var urlString: String {
            return "\(MovieApi.baseUrl)\(self.path)?api_key=\(MovieApi.apiKey)"
        }
}

