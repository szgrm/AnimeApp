//
//  CoverImageView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 5.08.2024.
//

import SwiftUI
import AnilistAPI

struct CoverImageView: View {
    let coverImageUrl: String
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            ImageView(
                url: coverImageUrl,
                width: (screenWidth - 30),
                height: 600,
                cornerRadius: 10
            )
        }
    }
}
