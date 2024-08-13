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
    let character: CharacterSmall

    var body: some View {
        VStack {
            ImageView(url: (character.image?.large)!, width: 70, height: 100, cornerRadius: 5)

            Text(character.name?.full ?? "unknown")
                .padding(.horizontal, 2)
                .frame(width: 70)
                .font(Font.custom("OpenSans", size: 11))
                .lineLimit(1)
        }
        .padding(.bottom, 5)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
    }
}
