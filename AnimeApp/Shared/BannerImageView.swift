//
//  BannerImageView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 30.07.2024.
//

import NukeUI
import SwiftUI

struct BannerImageView: View {
    let url: String
    let height: CGFloat
    let hex: String

    var body: some View {
        LazyImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: height)
            } else if phase.error != nil {
                Image(systemName: "questionmark.diamond")
                    .imageScale(.large)
                    .frame(width: .infinity, height: height)
            } else {
                Rectangle()
                    .foregroundStyle(Color(hex: hex))
                    .scaledToFill()
            }
        }
    }
}
