//
//  MovieListView.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 10/03/24.
//

import SwiftUI

struct MovieListView: View {
  
  @ObservedObject var viewModel: MovieListViewModel
  
  init(viewModel: MovieListViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    
    NavigationStack {
      List {
        ForEach(viewModel.movieList) { movieVM in
          NavigationLink {
            MovieDetailView(viewModel: MovieDetailViewModel(movieId: movieVM.id))
          } label: {
            MovieCardView(viewModel: movieVM)
              .background(.listBackground)
              .padding(.trailing, 8)
          }
          .tint(.white)
          .listRowBackground(EmptyView().foregroundStyle(.clear))
        }
        if viewModel.isMoreDataAvailable {
          lastRowView
            .listRowBackground(EmptyView().foregroundStyle(.clear))
        }
      }
      .refreshable {
        viewModel.getFreshList()
      }
      .overlay {
        if viewModel.movieList.isEmpty {
          ContentUnavailableView(Localization.noDataAvailableLatestMoview, systemImage: "magnifyingglass")
            .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xLarge/*@END_MENU_TOKEN@*/)
            .foregroundStyle(.white)
        }
      }
      .padding(.trailing, -30)
      .listStyle(.plain)
      .navigationTitle(viewModel.title)
      .navigationBarTitleDisplayMode(.large)
      .background(.listBackground)
    }
  }
  
  var lastRowView: some View {
    ZStack(alignment: .center) {
      switch viewModel.movieListState {
      case .loading:
        ProgressView()
      case .idle:
        EmptyView()
      }
    }
    .frame(height: 50)
    .onAppear {
      viewModel.getMovieList()
    }
  }
}

#Preview {
  MovieListView(viewModel: MovieListViewModel(listType: .latest))
}
