//
//  YoutubeVideoView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 30.07.2024.
//

import SwiftUI
import WebKit

struct YoutubeVideoView: View {
    let ID: String
    var body: some View {
        Video(videoID: ID)
            .frame(width: 350, height: 200)
            .cornerRadius(10)
    }
}

struct Video: UIViewRepresentable {
    let videoID: String
    func makeUIView(context _: Context) -> some WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: UIViewType, context _: Context) {
        guard let YoutubeUrl = URL(string: "https://www.youtube.com/embed/\(videoID)")
        else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: YoutubeUrl))
    }
}
