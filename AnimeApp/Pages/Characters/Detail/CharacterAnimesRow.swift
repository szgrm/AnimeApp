//
//  CharacterAnimesRow.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 4.08.2024.
//

import AnilistAPI
import SwiftUI

struct CharacterAnimesRow: View {
    let anime: Anime
    let screenWidth = UIScreen.main.bounds.size.width

    var body: some View {
        HStack(alignment: .top) {
            ImageView(
                url: anime.coverImage.large,
                width: 60,
                height: 90,
                cornerRadius: 5
            )
            .id(anime.id)

            VStack(alignment: .leading, spacing: 5) {
                Text(((anime.title.english) ?? (anime.title.romaji)) ?? "No Title")
                    .customFont(.regular, 16)
                    .lineLimit(1)

                HStack {
                    Text(anime.seasonYear)
                        .customFont(.regular, 12)
                        .foregroundStyle(.secondary)
                    Divider()
                        .frame(height: 10)
                    Text(anime.format.rawValue)
                        .customFont(.regular, 12)
                        .foregroundStyle(.secondary)
                }
                .padding(.leading, 2)

                HStack(spacing: 3) {
                    ForEach(anime.genres.prefix(3), id: \.self) { genre in
                        Text(genre)
                            .customFont(.regular, 10)
                            .padding(3)
                            .background(Color("AppColor").opacity(0.4))
                            .clipShape(.capsule)
                    }
                }
            }
            Spacer()
        }
    }
}
