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
            GeometryReader { geometry in
                LazyImage(url: URL(string: url)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    } else if phase.error != nil {
                        Image(systemName: "questionmark.diamond")
                            .imageScale(.large)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    } else {
                        Rectangle()
                            .foregroundStyle(Color(hex: hex))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            }
            .frame(height: height)
        }
}
