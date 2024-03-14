//
//  MovieCardView.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 11/03/24.
//

import SwiftUI

struct MovieCardView: View {
  
  @ObservedObject private var viewModel: MovieCardViewModel
  
  init(viewModel: MovieCardViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    
    HStack {
      AsyncImage(url: viewModel.backdropPath) { image in
        image
          .resizable()
          .scaledToFill()
          .frame(width: 120)
      } placeholder: {
        ProgressView()
          .frame(width: 120)
      }
      .clipped()
      
      VStack(alignment:.leading, spacing: 5) {
        Spacer()
        Text(viewModel.name)
          .lineLimit(2)
          .minimumScaleFactor(0.5)
          .foregroundColor(.white)
          .font(.title3)
          .fontWeight(.bold)
        
        Text(viewModel.overview ?? "")
          .foregroundColor(.gray)
          .font(.footnote)
          .fontWeight(.light)
        
        HStack {
          Text(viewModel.releaseYear)
            .foregroundColor(.white)
            .font(.footnote)
            .background(
              RoundedRectangle(cornerRadius: 4).stroke()
              .fill(.white)
              .padding(.leading,-4)
              .padding(.trailing, -4)
            )
            .padding(4)
          
          Text(viewModel.language)
            .foregroundColor(.white)
            .font(.footnote)
            .background(
              RoundedRectangle(cornerRadius: 4).stroke()
              .fill(.white)
              .padding(.leading,-4)
              .padding(.trailing, -4)
            )
            .padding(4)
        }
        Spacer()
        HStack {
          Image(systemName: "hand.thumbsup.fill")
          Text(viewModel.rating)
          Spacer()
        }
        .foregroundColor(.yellow)
        .fontWeight(.heavy)
        .padding(.bottom, 20)
      }
      .padding(.leading, 10)
      .padding(.trailing, 10)
    }
    .frame(height: 180)
    .background(.movieCardBackground)
    .cornerRadius(10)
    .listRowBackground(EmptyView().foregroundStyle(.clear))
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  MovieCardView(viewModel: MovieCardViewModel(
    id: "09877",
    backdropPath: URL(string: "https://image.tmdb.org/t/p/w500/vfEG79SQIg3p6B8rBLVeIo2BBhb.jpg")!,
    genres: "Action \u{00B7} Drama \u{00B7} Superhero",
    name: "Spiderman Accross The Spider Verse", 
    overview: "Spiderman Accross The Spider VerseSpiderman Accross The Spider VerseSpiderman Accross The Spider VerseSpiderman Accross The Spider Verse",
    releaseYear: "2023",
    language: "English",
    rating: "8.7"
  ))
}
