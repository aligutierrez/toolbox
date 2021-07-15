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
    @State private var currentIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                TabView(selection: $currentIndex) {
                    ForEach(moviesCarousel, id: \.self) { movie in
                        ForEach(movie.items, id: \.self) { item in
                            let randInt = Int.random(in: 1000...9999)
                            let url = URL(string: "\(item.imageUrl)?\(randInt)")
                            VStack {
                                ZStack {
                                    WebImage(url: url)
                                        .resizable()
                                        .indicator(.activity)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width,
                                               height: movie.type == "poster" ?
                                                geometry.size.height : geometry.size.height / 3)
                                        .onTapGesture {
                                            if item.videoUrl != nil {
                                                isPresented.toggle()
                                            }
                                        }
                                    
                                    HStack {
                                        Text("\(movie.title)")
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                            
                                        Spacer()
                                    }
                                    .padding()
                                }
                                
                                
                                HStack {
                                    Spacer()
                                    Text("\(item.title)")
                                    Spacer()
                                }
                                .padding()
                                
                                if movie.type == "thumb" {
                                    Spacer()
                                }
                            }
                            .fullScreenCover(isPresented: $isPresented) {
                                VideoPlayerView(url: item.videoUrl!)
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(width: geometry.size.width,
                       height:geometry.size.height)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
