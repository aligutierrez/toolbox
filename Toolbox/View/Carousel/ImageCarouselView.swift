//
//  ImageCarouselView.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/14/21.
//

import AVKit
import Combine
import SDWebImageSwiftUI
import SwiftUI

struct ImageCarouselView: View {
    
    var moviesCarousel: [MoviesCarousel]
    
    @State private var isPresented = false
    @State private var hasPreview = false
    @State private var currentIndex = 0
    @State private var slideGesture: CGSize = CGSize.zero
    @State private var items = [CarouselItem]()
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView() {
                TabView() {
                    ForEach(moviesCarousel, id: \.self) { movie in
                        ForEach(movie.items, id: \.self) { item in
                            let randInt = Int.random(in: 1000...9999)
                            let url = URL(string: "\(item.imageUrl)?\(randInt)")
                            VStack {
                                ZStack {
                                    WebImage(url: url)
                                        .resizable()
                                        .indicator(.activity)
                                        .edgesIgnoringSafeArea(.all)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width,
                                               height: movie.type == "poster" ?
                                               geometry.size.height : geometry.size.height / 3)
                                        .onTapGesture {
                                            if item.videoUrl != nil {
                                                isPresented.toggle()
                                            }
                                        }
                                    
                                    VStack {
                                        HStack {
                                            Text("\(movie.title)")
                                                .font(.largeTitle)
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                        }
                                        .padding()
                                        
                                        HStack {
                                            Text("\(item.title)")
                                                .font(.title )
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        .padding()
                                        
                                        if let videoUrl = item.videoUrl,
                                           !videoUrl.isEmpty {
                                            HStack {
                                                Spacer()
                                                let camera = UIImage(systemName: "camera.fill")
                                                Image(uiImage: camera!)
                                                    .padding()
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .edgesIgnoringSafeArea(.all)
                            .fullScreenCover(isPresented: $isPresented) {
                                if let videoUrl = item.videoUrl,
                                   !videoUrl.isEmpty {
                                    VideoPlayerView(url: videoUrl)
                                }
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .edgesIgnoringSafeArea(.all)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.setupAppearance()
                self.joinItems()
            }
        }
    }
    
    
    func joinItems() {
        for movie in moviesCarousel {
            for item in movie.items {
                items.append(item)
            }
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}
