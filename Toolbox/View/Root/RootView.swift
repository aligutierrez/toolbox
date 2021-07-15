//
//  RootView.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/13/21.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: HomeView(),
                    isActive: $viewModel.isLoggedIn) {
                    EmptyView()
                }
                
                LoginView()
            }
        }
    }
  }


struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
