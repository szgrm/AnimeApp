//
//  ImageView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 21.07.2024.
//

import NukeUI
import SwiftUI

struct ImageView: View {
    let url: String
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat

    var body: some View {
        LazyImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(cornerRadius)
            } else if phase.error != nil {
                Image(systemName: "questionmark.diamond")
                    .imageScale(.large)
                    .frame(width: width, height: height)
            } else {
                ProgressView()
                    .foregroundStyle(.secondary)
                    .frame(width: width, height: height)
            }
        }
    }
}
