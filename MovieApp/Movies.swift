//
//  Movies.swift
//  MovieApp
//
//  Created by Engy on 9/28/24.
//

import Foundation

// MARK: - Welcome
struct Movies: Codable {
    let dates: Dates?
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result
struct Movie: Codable,Identifiable {
    let id: Int
    let posterPath, releaseDate, title: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
struct MovieResponse: Codable {
    let results: [Movie]
}

