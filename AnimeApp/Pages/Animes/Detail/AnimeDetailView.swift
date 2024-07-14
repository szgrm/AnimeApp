//
//  AnimeDetailView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import SwiftUI
import AnilistAPI

struct AnimeDetailView: View {
    let anime: GetAnimesQuery.Data.Page.Medium
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationTitle(anime.title?.english ?? "Anime Detail")
            .navigationBarTitleDisplayMode(.inline)
    }
}

