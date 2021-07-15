//
//  HomeView.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/13/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var viewModel = HomeViewViewModel()
    @State var carousel: [MoviesCarousel] = [MoviesCarousel]()
    
    var body: some View {
            VStack {
                ImageCarouselView(moviesCarousel: carousel)
                    .onAppear() {
                        self.getData()
                    }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
    }
    
    func getData() {
        carousel.removeAll()
        viewModel.getData { carousel , error  in
            if let error = error {
                print(error.localizedDescription)
                loginViewModel.needsAuthentication = true
                loginViewModel.isLoggedIn = false
                return
            }
            
            guard let carousel = carousel else { return }
            self.carousel = carousel
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
