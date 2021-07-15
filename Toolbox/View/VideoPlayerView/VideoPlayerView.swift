//
//  VideoPlayerView.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/15/21.
//

import AVKit
import SwiftUI

struct VideoPlayerView: View {
    
    var url: String
    var body: some View {
        let player = AVPlayer(url: URL(string: url)!)
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                player.play()
            }
            .onDisappear() {
                player.pause()
            }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(url: "https://d11gqohmu80ljn.cloudfront.net/128/media-20210712191955-cbdi-0.m3u8/master.m3u8")
    }
}
