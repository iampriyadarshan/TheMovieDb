//
//  CastView.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 13/03/24.
//

import SwiftUI

struct CastView: View {
  
  let cast: CastProfile
  
  var body: some View {
    VStack {
      AsyncImage(url: cast.profileUrl) { image in
        image
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 120)
          .clipShape(RoundedRectangle(cornerRadius: 15))
      } placeholder: {
        ProgressView()
          .frame(width: 100, height: 120)
      }
      Text(cast.name)
        .foregroundStyle(.white)
        .lineLimit(1)
        .frame(width: 100)
      Text(cast.character ?? "")
        .foregroundStyle(.white)
        .font(.footnote)
        .lineLimit(1)
        .frame(width: 100)
    }
  }
  
}

struct CastProfile: Decodable, Identifiable {
  let id: String
  let name: String
  let character: String?
  let profileUrl: URL?
}

#Preview {
  CastView(cast: CastProfile(id: "1234", name: "Priyadarshan", character: "Myself", profileUrl: URL(string: "https://media.themoviedb.org/t/p/w600_and_h900_bestv2/A1yhe60nSCzLS0wuy7MwgcL4uIl.jpg")!))
}
