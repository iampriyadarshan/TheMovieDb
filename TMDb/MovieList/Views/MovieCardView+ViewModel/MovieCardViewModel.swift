//
//  MovieCardViewModel.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 12/03/24.
//

import Foundation


class MovieCardViewModel: ObservableObject, Identifiable {
  let id: String
  let backdropPath: URL?
  let genres: String
  let name: String
  let overview: String?
  let releaseYear: String
  let language: String
  let rating: String
  init(id: String, backdropPath: URL?, genres: String, name: String, overview: String?, releaseYear: String, language: String, rating: String) {
    self.id = id
    self.backdropPath = backdropPath
    self.genres = genres
    self.name = name
    self.overview = overview
    self.releaseYear = releaseYear
    self.language = language
    self.rating = rating
  }
}
