//
//  AnimeListRowView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import AnilistAPI
import NukeUI
import SwiftUI

struct AnimeListRowView: View {
    let anime: Anime
    let screenWidth = UIScreen.main.bounds.size.width

    var body: some View {
        HStack(alignment: .top) {
            ImageView(
                url: anime.coverImage.large,
                width: 120,
                height: 180,
                cornerRadius: 10
            )
            .id(anime.id)

            VStack(alignment: .leading, spacing: 5) {
                Text(((anime.title.english) ?? (anime.title.romaji)) ?? "No Title")
                    .customFont(.bold, 20)
                    .lineLimit(1)

                HStack {
                    Text(anime.seasonYear)
                        .foregroundStyle(.secondary)
                        .customFont(.regular, 12)
                    Divider()
                        .frame(height: 10)
                    Text(anime.format.rawValue)
                        .foregroundStyle(.secondary)
                        .customFont(.regular, 12)
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

                TextUtility.cleanDescription(anime.description)
                    .customFont(.regular, 10)
                    .frame(width: screenWidth * 3 / 5, alignment: .leading)
                    .lineLimit(6)
                    .multilineTextAlignment(.leading)
            }
            .frame(width: screenWidth * 3 / 5)
            .padding(5)
        }
        .padding(5)
    }
}
