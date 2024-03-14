//
//  NetworkConstants.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 12/03/24.
//

import Foundation


public final class AppNetworkConstantsProvider {

 public static var shared = AppNetworkConstantsProvider()

 private init() {}

  public var networkUrl : URL {
   URL(string: "https://api.themoviedb.org/3")!
 }
  
  var apiKey: [String: String] {
    ["api_key" : "909594533c98883408adef5d56143539"]
  }
  
  let backdropThumbnailBaseUrl = URL(string: "https://image.tmdb.org/t/p/w500")
  let castBaseUrl = URL(string: "https://media.themoviedb.org/t/p/w276_and_h350_face/")
}


enum Localization {
  static let noDataAvailableLatestMoview = "No Articles for Latest Movie"
  static let noDataAvailableTopTatedMoview = "No Articles for Top Rated Movie"
}
