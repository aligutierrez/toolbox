//
//  HomeViewModel.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/13/21.
//

import Foundation

import SwiftUI
import Combine

class HomeViewViewModel: ObservableObject, Identifiable {
    
    @Published var carousel: [MoviesCarousel] = [MoviesCarousel]()

    
    func getData(completion: @escaping ([MoviesCarousel]?, Error?) ->Void) {
        serviceLocator
            .webService
            .getData(errorType: LoginError.self)
            .execute(onSuccess: { carousel in
                self.carousel = carousel
                completion(carousel, nil)
            }, onFailure: {error in
                print(error.localizedDescription)
                completion(nil, error)
            })
    }
}
