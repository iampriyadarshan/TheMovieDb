//
//  CommonExtentions.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 12/03/24.
//

import Foundation
import Jaal


extension TargetType {
  var baseURL: URL {
    AppNetworkConstantsProvider.shared.networkUrl
  }
}
