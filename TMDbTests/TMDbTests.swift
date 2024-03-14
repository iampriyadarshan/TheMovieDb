//
//  TMDbTests.swift
//  TMDbTests
//
//  Created by Priyadarshan Meshram on 14/03/24.
//

import XCTest
import Combine
import Jaal
@testable import TMDb

final class TMDbTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testEmptyState() {
    let repository = MockedMovieListRepository()
    repository.movieList = []
    InjectedValues[\.movieListRepository] = repository
    let vm = MovieListViewModel(listType: .latest)
    vm.getMovieList()
    XCTAssertTrue(vm.movieList.isEmpty)
  }
  
  func testDataState() {
    let repository = MockedMovieListRepository()
    repository.movieList = MovieListDataGenerator.getMovieList(count: 10)
    InjectedValues[\.movieListRepository] = repository
    let vm = MovieListViewModel(listType: .latest)
    vm.getMovieList()
    XCTAssertTrue(vm.movieList.count == 10)
  }
}





class MockedMovieListRepository: MovieListRepositoryType {
  var movieList : [Movie] = []
  func getMovieList(language: String, page: String, listType: TMDb.MovieListType) -> AnyPublisher<TMDb.MovieListResponse, Jaal.JaalError> {
    let hardcodedResponse = TMDb.MovieListResponse(dates: nil, page: 0, results: movieList, totalPages: 1, totalResults: 0)
    return Just(hardcodedResponse)
      .setFailureType(to: Jaal.JaalError.self) // Set failure type to JaalError
      .eraseToAnyPublisher()
  }
}


enum MovieListDataGenerator {
  
  static func getMovieList(count: Int) -> [Movie] {
    var movieList : [Movie] = []
    for i in (0...count - 1) {
      let movie  = Movie(
        adult: false,
        backdropPath: "path\(i)",
        genreIds: [],
        id: 1234,
        originalTitle: "Homecoming\(i)",
        overview: "No overview\(i)",
        popularity: 8.9,
        posterPath: "Not available\(i)",
        releaseDate: "06-10-2023",
        title: "Homecoming\(i)",
        video: false,
        voteAverage: 8.9,
        voteCount: 300
      )
      movieList.append(movie)
    }
    return movieList
  }
}
