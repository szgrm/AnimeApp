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
    let anime: AnimeSmall
    let screenWidth = UIScreen.main.bounds.size.width

    var body: some View {
        HStack(alignment: .top) {
            ImageView(
                url: (anime.coverImage?.large)!,
                width: 120,
                height: 180,
                cornerRadius: 10
            )
            .id(anime.id)

            VStack(alignment: .leading, spacing: 5) {
                Text(((anime.title?.english) ?? (anime.title?.romaji)) ?? "No Title")
                    .bold()
                    .font(Font.custom("OpenSans", size: 20))
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

                TextUtility.cleanDescription(anime.description ?? "")
                    .frame(width: screenWidth * 3 / 5, alignment: .leading)
                    .lineLimit(6)
                    .font(Font.custom("OpenSans", size: 10))
                    .multilineTextAlignment(.leading)
            }
            .frame(width: screenWidth * 3 / 5)
            .padding(5)
        }
        .padding(5)
    }
}
