//
//  MovieDetailResponse.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 14/03/24.
//

import Foundation

struct MovieDetailResponse: Codable {
  let adult: Bool
  let backdropPath: String
//  let belongsToCollection: BelongsToCollection
  let budget: Int
  let genres: [Genre]
  let homepage: String
  let id: Int
  let imdbID, originalLanguage, originalTitle, overview: String
  let popularity: Double
  let posterPath: String
//  let productionCompanies: [ProductionCompany]
//  let productionCountries: [ProductionCountry]
  let releaseDate: String
  let revenue, runtime: Int
//  let spokenLanguages: [SpokenLanguage]
  let status, tagline, title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
//    case belongsToCollection = "belongs_to_collection"
    case budget, genres, homepage, id
    case imdbID = "imdb_id"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
//    case productionCompanies = "production_companies"
//    case productionCountries = "production_countries"
    case releaseDate = "release_date"
    case revenue, runtime
//    case spokenLanguages = "spoken_languages"
    case status, tagline, title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

// MARK: - BelongsToCollection
//struct BelongsToCollection: Codable {
//  let id: Int
//  let name, posterPath, backdropPath: String
//  
//  enum CodingKeys: String, CodingKey {
//    case id, name
//    case posterPath = "poster_path"
//    case backdropPath = "backdrop_path"
//  }
//}

// MARK: - Genre
struct Genre: Codable {
  let id: Int
  let name: String
}

//// MARK: - ProductionCompany
//struct ProductionCompany: Codable {
//  let id: Int
//  let logoPath, name, originCountry: String
//  
//  enum CodingKeys: String, CodingKey {
//    case id
//    case logoPath = "logo_path"
//    case name
//    case originCountry = "origin_country"
//  }
//}

//// MARK: - ProductionCountry
//struct ProductionCountry: Codable {
//  let iso3166_1, name: String
//  
//  enum CodingKeys: String, CodingKey {
//    case iso3166_1 = "iso_3166_1"
//    case name
//  }
//}

// MARK: - SpokenLanguage
//struct SpokenLanguage: Codable {
//  let englishName, iso639_1, name: String
//  
//  enum CodingKeys: String, CodingKey {
//    case englishName = "english_name"
//    case iso639_1 = "iso_639_1"
//    case name
//  }
//}



struct CreaditsResponse: Codable {
  let id: Int
  let cast, crew: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
  let adult: Bool
  let gender, id: Int
  let knownForDepartment, name, originalName: String
  let popularity: Double
  let profilePath: String?
  let castID: Int?
  let character: String?
  let creditID: String
  let order: Int?
  let department, job: String?
  
  enum CodingKeys: String, CodingKey {
    case adult, gender, id
    case knownForDepartment = "known_for_department"
    case name
    case originalName = "original_name"
    case popularity
    case profilePath = "profile_path"
    case castID = "cast_id"
    case character
    case creditID = "credit_id"
    case order, department, job
  }
}
