//
//  MoviesCarousel.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/13/21.
//

import Foundation

struct MoviesCarousel: Codable, Hashable {
    var title: String
    var type: String
    var items: [CarouselItem]
}

struct CarouselItem: Codable, Hashable {
    var title: String
    var imageUrl: String
    var videoUrl: String?
    var description: String
}
