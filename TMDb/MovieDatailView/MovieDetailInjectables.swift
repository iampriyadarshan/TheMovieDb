//
//  MovieDetailInjectables.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 14/03/24.
//

import Foundation


private struct MovieDetailRepositoryKey: InjectionKey {
  static var currentValue: MovieDetailRepositoryType = MovieDetailRepository()
}

extension InjectedValues {
  var movieDetailRepository: MovieDetailRepositoryType {
    get { Self[MovieDetailRepositoryKey.self] }
    set { Self[MovieDetailRepositoryKey.self] = newValue }
  }
}
