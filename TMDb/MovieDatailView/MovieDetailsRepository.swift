//
//  MovieDetailsRepository.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 13/03/24.
//

import Foundation
import Jaal
import Combine


protocol MovieDetailRepositoryType {
  func getMovieDetails(
    id: String,
    language: String
  ) -> AnyPublisher<MovieDetailResponse, JaalError>
  
  func getMovieCreadits(
    id: String,
    language: String
  ) -> AnyPublisher<CreaditsResponse, JaalError>
}

struct MovieDetailRepository: MovieDetailRepositoryType {
  private let network = JaalProvider<MovieDetailsTarget>()
  
  func getMovieDetails(
    id: String,
    language: String
  ) -> AnyPublisher<MovieDetailResponse, JaalError> {
    network.request(
      target: .detail(id: id, language: language),
      scheduler: DispatchQueue.main,
      type: MovieDetailResponse.self
    )
  }
  
  func getMovieCreadits(id: String, language: String) -> AnyPublisher<CreaditsResponse, JaalError> {
    network.request(
      target: .credits(id: id, language: language),
      scheduler: DispatchQueue.main,
      type: CreaditsResponse.self
    )
  }
}

fileprivate extension MovieListType {
  func targetType(language: String, page: String) -> MovieListTarget {
    switch self {
    case .latest:
        .latest(language: language, page: page)
    case .topRated:
        .topRated(language: language, page: page)
    }
  }
}


enum MovieDetailsTarget: TargetType {
  
  case detail(id: String, language : String)
  case credits(id: String, language : String)
    
  var path: String {
    switch self {
    case let .detail(id, _):
      "/movie/\(id)"
    case let .credits(id, _):
      "/movie/\(id)/credits"
    }
  }
  
  var method: HTTPMethod {
    .get
  }
  
  var task: HTTPTaskType {
    switch self {
    case let .detail(_, language):
      .requestParameters(parameters: ["language" : language].merging(AppNetworkConstantsProvider.shared.apiKey) { $1 })
    case let .credits(_, language):
        .requestParameters(parameters:  ["language" : language].merging(AppNetworkConstantsProvider.shared.apiKey) { $1 })
    }
  }
  
  var headers: [String : String]? {
    nil
  }
}
