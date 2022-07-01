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
    @State var shouldDisplayCarousel = false
    
    var body: some View {
        VStack(alignment: .leading) {
                if shouldDisplayCarousel {
                    ImageCarouselView(moviesCarousel: carousel)
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity,
                   alignment: .topLeading)
            .onAppear() {
                self.getData()
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("")
            .navigationBarHidden(true)
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
            self.shouldDisplayCarousel = true
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
