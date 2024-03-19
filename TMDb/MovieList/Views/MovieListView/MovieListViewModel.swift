//
//  MovieListViewModel.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 10/03/24.
//

import Foundation
import Combine



enum MovieListState {
  case loading
  case idle
}

class MovieListViewModel: ObservableObject {
  
  //MARK: Injectables
  @Injected(\.movieListRepository) private var repository: MovieListRepositoryType
  
  private let listType : MovieListType
#warning("TODO: Make Language dynamic... Hard coded as of now...")
  private let language = "en-US" // Hard coded as of now
  
  var title: String {
    get {
      listType.name + " Movies"
    }
  }
  
  var isMoreDataAvailable : Bool = true
  var movieListState: MovieListState = .idle
  private var currentPage = 0
  private var cancellables = Set<AnyCancellable>()
  
  @Published var movieList: [MovieCardViewModel] = [MovieCardViewModel]()
  
  init(listType: MovieListType) {
    self.listType = listType
  }
  
  func getFreshList() {
    currentPage = 1
    movieList.removeAll()
    getMovieList()
  }
  
  func getMovieList() {
    movieListState = .loading
    print("Current Page: \(currentPage + 1)")
    repository.getMovieList(language: language, page: "\(currentPage + 1)", listType: listType)
      .tryMap { [weak self] in
        self?.isMoreDataAvailable = self?.movieList.count ?? 0 < $0.totalResults
        self?.currentPage = $0.page
        return $0.results?.compactMap { $0.toMovieCardViewModel }
      }
      .sink( receiveCompletion: { [weak self] error in
        print(error)
        self?.movieListState = .idle
      },receiveValue: { [weak self] response in
        self?.movieListState = .idle
        self?.movieList.append(contentsOf: response ?? [])
      })
      .store(in: &cancellables)
    
     #warning("Handle error grasefullystate by intrducing diff states and more cases")
  }
}


fileprivate extension Movie {
  var toMovieCardViewModel : MovieCardViewModel {
    MovieCardViewModel(
      id: "\(id)",
      backdropPath: AppNetworkConstantsProvider.shared.backdropThumbnailBaseUrl?.appendingPathComponent(posterPath, conformingTo: .image),
      genres: "",
      name: originalTitle,
      overview: overview.trimmingCharacters(in: .whitespacesAndNewlines),
      releaseYear: releaseDate,
      language: "English",
      rating: String(format: "%.1f", voteAverage)
    )
  }
}


extension MovieListViewModel {
  var tagValue: Int {
    listType.tagValue
  }
  
  var imageName: String {
    listType.imageName
  }
  
  var name: String {
    listType.name
  }
}
