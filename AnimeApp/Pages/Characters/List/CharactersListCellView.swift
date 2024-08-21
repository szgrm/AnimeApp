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
    let character: Characters
    var body: some View {
        VStack {
            ImageView(
                url: character.image.large,
                width: 110,
                height: 165,
                cornerRadius: 10
            )

            Text(character.name.full)
                .customFont(.bold, 14)
                .padding(.bottom, 5)
                .frame(height: 40)
                .lineLimit(2)
        }
        .frame(width: 110, height: 215)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.top, 10)
    }
}
