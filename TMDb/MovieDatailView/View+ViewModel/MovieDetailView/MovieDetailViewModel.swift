//
//  MovieDetailViewModel.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 13/03/24.
//

import Foundation
import Combine
import Jaal

class MovieDetailViewModel: ObservableObject {
  
  @Injected(\.movieDetailRepository) private var repository: MovieDetailRepositoryType
  
  @Published var movieDetail: MovieDetails?
  private var cancellables = Set<AnyCancellable>()
  
  #warning("TODO: Make Language dynamic... Hard coded as of now...")
  private let language = "en-US" // Hard coded as of now
  private let movieId: String
  
  init(movieId: String) {
    self.movieId = movieId
  }
  
  func getDetails() {
    repository.getMovieDetails(id: movieId, language: language)
      .flatMap { [self] movieDetailResponse in
        movieCreadits()
          .map { (movieDetailResponse, $0) }
          .eraseToAnyPublisher()
      }
      .toMovieDetails()
      .sink { error in
        print(error)
      } receiveValue: { [weak self] movieDetail in
        self?.movieDetail = movieDetail
      }
      .store(in: &cancellables)
  }
  
  func movieCreadits() -> AnyPublisher<[Cast], Never> {
    repository.getMovieCreadits(id: movieId, language: language)
      .map(\.cast)
      .replaceError(with: [])
      .eraseToAnyPublisher()
  }
  
}


struct MovieDetails {
  let posterUrl: URL?
  let movieName: String
  let movieOverview: String
  let movieCast: [CastProfile]
  let genres: String
}


extension Cast {
  func toCastProfile() -> CastProfile {
    CastProfile(
      id: "\(id)",
      name: originalName,
      character: character,
      profileUrl: AppNetworkConstantsProvider.shared.castBaseUrl?.appending(path: profilePath ?? "")
    )
  }
}

extension Publisher where Output == (MovieDetailResponse, [Cast]), Failure == JaalError {
  func toMovieDetails() -> AnyPublisher<MovieDetails, JaalError> {
    map {
      MovieDetails(
        posterUrl: AppNetworkConstantsProvider.shared.backdropThumbnailBaseUrl?.appendingPathComponent($0.0.backdropPath, conformingTo: .image),
        movieName: $0.0.originalTitle,
        movieOverview: $0.0.overview,
        movieCast: $0.1.map { $0.toCastProfile() }, 
        genres: $0.0.genres.map { $0.name }.joined(separator: " · ")
      )
    }
    .eraseToAnyPublisher()
  }
}
