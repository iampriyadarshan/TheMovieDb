//
//  ResponseModels.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 11/03/24.
//

import Foundation

// MARK: - ListResponse
struct MovieListResponse: Decodable {
  let dates: Dates?
  let page: Int
  let results: [Movie]?
  let totalPages, totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case dates, page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Dates
struct Dates: Decodable {
  let maximum, minimum: String
}

// MARK: - Result
struct Movie: Decodable {
  let adult: Bool
  let backdropPath: String
  let genreIds: [Int]
  let id: Int
//  let originalLanguage: OriginalLanguage
  let originalTitle, overview: String
  let popularity: Double
  let posterPath, releaseDate, title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIds = "genre_ids"
    case id
//    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

enum OriginalLanguage: String, Decodable {
  case en = "en"
  case es = "es"
  case pt = "pt"
}
