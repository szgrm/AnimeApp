//
//  CharacterGridView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 20.07.2024.
//

import AnilistAPI
import NukeUI
import SwiftUI

struct CharacterGridView: View {
    let character: GetAnimeDetailQuery.Data.Media.Characters.Node

    var body: some View {
        VStack {
            AniImageView(url: (character.image?.medium)!, width: 70, height: 100, cornerRadius: 5)

            Text(character.name?.full ?? "unknown")
                .font(.system(size: 13))
                .lineLimit(1)
        }
        .padding(.bottom, 5)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
    }
}
