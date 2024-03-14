//
//  MovieListInjectables.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 12/03/24.
//

import Foundation

private struct MovieListRepositoryKey: InjectionKey {
  static var currentValue: MovieListRepositoryType = MovieListRepository()
}

extension InjectedValues {
  var movieListRepository: MovieListRepositoryType {
    get { Self[MovieListRepositoryKey.self] }
    set { Self[MovieListRepositoryKey.self] = newValue }
  }
}
