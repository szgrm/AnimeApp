//
//  CharactersListCellView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 31.07.2024.
//

import AnilistAPI
import NukeUI
import SwiftUI

struct CharactersListCellView: View {
    let character: CharacterSmall
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            AniImageView(
                url: (character.image?.large)!,
                width: 100,
                height: 150,
                cornerRadius: 10
            )

            Text(character.name?.full ?? "unknown")
                .bold()
                .font(.system(size: 16))
                .lineLimit(1)
                .padding(.horizontal, 5)
                .frame(alignment: .leading)

            Text((character.media?.nodes?[0]?.title?.english ?? character.media?.nodes?[0]?.title?.romaji) ?? "")
                .font(.system(size: 10))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 5)
                .padding(.bottom, 5)
                .lineLimit(1)
                .frame(alignment: .leading)
        }
        .frame(width: 100)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.top, 10)
    }
}
