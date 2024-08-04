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
        VStack {
            ImageView(
                url: (character.image?.large)!,
                width: 110,
                height: 165,
                cornerRadius: 10
            )

            Text(character.name?.full ?? "unknown")
                .bold()
                .padding(.bottom, 5)
                .frame(height: 40)
                .font(.system(size: 14))
                .lineLimit(2)
        }
        .frame(width: 110, height: 215)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.top, 10)
    }
}
