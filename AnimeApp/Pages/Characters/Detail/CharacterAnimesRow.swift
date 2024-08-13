//
//  CharacterAnimesRow.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 4.08.2024.
//

import AnilistAPI
import SwiftUI

struct CharacterAnimesRow: View {
    let anime: AnimeSmall
    let screenWidth = UIScreen.main.bounds.size.width

    var body: some View {
        HStack(alignment: .top) {
            ImageView(
                url: (anime.coverImage?.large)!,
                width: 60,
                height: 90,
                cornerRadius: 5
            )
            .id(anime.id)

            VStack(alignment: .leading, spacing: 5) {
                Text(((anime.title?.english) ?? (anime.title?.romaji)) ?? "No Title")
                    .font(Font.custom("OpenSans", size: 16))
                    .lineLimit(1)

                HStack {
                    Text("\(String(anime.seasonYear ?? 0))")
                        .foregroundStyle(.secondary)
                        .font(Font.custom("OpenSans", size: 12))
                    Divider()
                        .frame(height: 10)
                    Text(anime.format?.rawValue ?? "-")
                        .foregroundStyle(.secondary)
                        .font(Font.custom("OpenSans", size: 12))
                }
                .padding(.leading, 2)

                HStack(spacing: 3) {
                    ForEach(anime.genres?.prefix(3) ?? [], id: \.self) { genre in
                        Text(genre!)
                            .font(Font.custom("OpenSans", size: 10))
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
