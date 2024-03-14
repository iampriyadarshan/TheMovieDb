//
//  MovieDetailView.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 13/03/24.
//

import SwiftUI

struct MovieDetailView: View {
  
  @Environment(\.dismiss) var dismiss
  
  @ObservedObject var viewModel: MovieDetailViewModel
  
  private let headerHeight: CGFloat = 400
  
  init(viewModel: MovieDetailViewModel) {
    self.viewModel = viewModel
  }
  
  
  var body: some View {
    ScrollView {
      ZStack {
        
        Color.listBackground.ignoresSafeArea()
        
        GeometryReader { geo in
          VStack {
            AsyncImage(url: viewModel.movieDetail?.posterUrl) { image in
              image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: geo.size.width, maxHeight: headerHeight)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .ignoresSafeArea(edges: .top)
            } placeholder: {
              ProgressView()
            }
            Spacer()
          }
        }
        
        
        VStack(alignment: .leading, spacing: 12) {
          
          
          Spacer()
            .frame(height: headerHeight)
          Text(viewModel.movieDetail?.genres ?? "")
            .foregroundStyle(.white)
            .font(.footnote)
          
          HStack {
            Text(viewModel.movieDetail?.movieName ?? "")
              .foregroundStyle(.white)
              .font(.title)
              .fontWeight(.heavy)
            Spacer()
            // ratings here
          }
          
          HStack {
            // genre tags
            
            // running time
          }
          
          HStack {
            Text("About film")
              .font(.title3)
              .fontWeight(.bold)
              .foregroundStyle(.white)
            Spacer()
            // see all button
          }
          
          Text(viewModel.movieDetail?.movieOverview ?? "")
            .foregroundStyle(.white)
            .font(.subheadline)
          
          HStack {
            Text("Cast & Crew")
              .font(.title3)
              .fontWeight(.bold)
              .foregroundStyle(.white)
            Spacer()
            // see all button
          }
          
          ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
              ForEach(viewModel.movieDetail?.movieCast ?? []) { cast in
                CastView(cast: cast)
              }
            }
          }
        }
        .padding()
        
      }
      .onAppear {
        viewModel.getDetails()
      }
      .overlay(alignment: .topLeading) {
        Button {
          dismiss()
        } label: {
          Image(systemName: "chevron.left")
            .imageScale(.large)
            .fontWeight(.bold)
            .tint(.white)
            .padding(.top, 50)
        }
        .padding(.leading)
      }
      .toolbar(.hidden, for: .navigationBar)
    }
    .ignoresSafeArea(edges: .top)
    .background(.listBackground)
  }
}

#Preview {
  MovieDetailView(viewModel: MovieDetailViewModel(movieId: "1011985"))
}
