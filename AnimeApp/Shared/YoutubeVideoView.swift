//
//  YoutubeVideoView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 30.07.2024.
//

import SwiftUI
import WebKit

struct YoutubeVideoView: View {
    let youtubeId: String
    var body: some View {
        Video(videoID: youtubeId)
    }
}

struct Video: UIViewRepresentable {
    let videoID: String
    func makeUIView(context _: Context) -> some WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: UIViewType, context _: Context) {
        guard let youtubeUrl = URL(string: "https://www.youtube.com/embed/\(videoID)")
        else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeUrl))
    }
}
