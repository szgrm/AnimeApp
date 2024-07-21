//
//  CharacterGridView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 20.07.2024.
//

import SwiftUI
import AnilistAPI
import NukeUI

struct CharacterGridView: View {
    let character: GetAnimeDetailQuery.Data.Media.Characters.Node
    
    var body: some View {
        VStack {
            LazyImage(url: URL(string: (character.image?.medium)!)) { phase in
                if let charImage = phase.image {
                    charImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75)
                } else if phase.error != nil {
                    Image(systemName: "questionmark.diamond")
                        .imageScale(.large)
                        .frame(width: 75, height: 100)
                } else {
                    ProgressView()
                }
            }
            Text(character.name?.full ?? "unknown")
                .font(.system(size: 13))
                .lineLimit(1)
        }
    }
}

