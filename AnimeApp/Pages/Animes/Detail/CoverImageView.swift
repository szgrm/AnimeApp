//
//  CoverImageView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 5.08.2024.
//

import AnilistAPI
import SwiftUI

struct CoverImageView: View {
    let coverImageUrl: String
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            ImageView(
                url: coverImageUrl,
                width: screenWidth - 30,
                height: screenHeight * 2 / 3,
                cornerRadius: 10
            )
        }
    }
}
