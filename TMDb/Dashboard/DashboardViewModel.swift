//
//  DashboardViewModel.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 10/03/24.
//

import Foundation


enum MovieListType : Hashable {
  case latest
  case topRated
  
  var tagValue: Int {
    switch self {
    case .latest:
      1
    case .topRated:
      2
    }
  }
  
  var imageName: String {
    switch self {
    case .latest:
      "theaters"
    case .topRated:
      "movie"
    }
  }
  
  var name: String {
    switch self {
    case .latest:
      "Latest"
    case .topRated:
      "Top Rated"
    }
  }
}


class DashboardViewModel: ObservableObject {
  private let tabs: [MovieListType]
  
  @Published var viewModelForListTypes: [MovieListViewModel] = []
  
  init(tabs: [MovieListType]) {
    self.tabs = tabs
  }
  
  func buildViewModelForListTypes() {
    tabs.forEach { tab in
      viewModelForListTypes.append(MovieListViewModel(listType: tab))
    }
  }
}
