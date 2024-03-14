//
//  MovieRepository.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 12/03/24.
//

import Foundation
import Jaal
import Combine


protocol MovieListRepositoryType {
  func getMovieList(
    language: String,
    page: String,
    listType : MovieListType
  ) -> AnyPublisher<MovieListResponse, JaalError>
}

struct MovieListRepository: MovieListRepositoryType {
  
  private let network = JaalProvider<MovieListTarget>()
  
  func getMovieList(
    language: String,
    page: String,
    listType: MovieListType
  ) -> AnyPublisher<MovieListResponse, JaalError> {
    network.request(
      target: listType.targetType(language: language, page: page),
      scheduler: DispatchQueue.main,
      type: MovieListResponse.self
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


enum MovieListTarget: TargetType {
  
  case latest(language: String, page: String)
  case topRated(language: String, page: String)
  
  
  var path: String {
    switch self {
    case .latest:
      "/movie/now_playing"
    case .topRated:
      "/movie/top_rated"
    }
  }
  
  var method: HTTPMethod {
    .get
  }
  
  var task: HTTPTaskType {
    switch self {
    case .latest(let language, let page):
      .requestParameters(parameters: ["language" : language,
                                      "page": page].merging(AppNetworkConstantsProvider.shared.apiKey) { $1 })
    case .topRated(let language, let page):
      .requestParameters(parameters: ["language" : language,
                                      "page" : page].merging(AppNetworkConstantsProvider.shared.apiKey) { $1 })
    }
  }
  
  var headers: [String : String]? {
    nil
  }
}
