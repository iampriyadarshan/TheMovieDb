//
//  MovieListView.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 10/03/24.
//

import SwiftUI

struct MovieListView: View {
  
  @ObservedObject var viewModel: MovieListViewModel
  @State private var viewLoaded = false
  
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
        }
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
      .onAppear {
        if !viewLoaded  {
          viewLoaded = true
          viewModel.getMovieList()
        }
      }
      
    }
  }
  
  var lastRowView: some View {
    ZStack(alignment: .center) {
      switch viewModel.movieListState {
      case .loading:
        ProgressView()
          .foregroundStyle(.listBackground)
      case .idle:
        EmptyView()
          .foregroundStyle(.listBackground)
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
