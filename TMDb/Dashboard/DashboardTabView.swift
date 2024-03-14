//
//  ContentView.swift
//  TMDb
//
//  Created by Priyadarshan Meshram on 09/03/24.
//

import SwiftUI
import Combine

struct DashboardTabView: View {
  
  @StateObject private var viewModel: DashboardViewModel = DashboardViewModel(tabs: [.latest, .topRated])
  @State private var viewLoaded = false
  
  
  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    UITabBar.appearance().backgroundColor = .listBackground
    
  }
  
  var body: some View {
    TabView {
      ForEach(viewModel.viewModelForListTypes, id: \.tagValue) { vm in
        MovieListView(viewModel: vm)
          .tabItem {
            VStack {
              Image(vm.imageName)
              Text(vm.name)
                .fontWeight(.bold)
            }
          }
          .tag(vm.tagValue)
      }
    }
    .onAppear {
      if !viewLoaded  {
        viewLoaded = true
        viewModel.buildViewModelForListTypes()
      }
    }
    .tint(.white)
    
  }
}





#Preview {
  DashboardTabView()
}
