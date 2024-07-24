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
    let anime: GetAnimesQuery.Data.Page.Medium

    var body: some View {
        HStack {
            AniImageView(
                url: (anime.coverImage?.large)!,
                width: 100,
                height: 150,
                cornerRadius: 15
            )

            VStack(alignment: .leading) {
                Text((anime.title?.english) ?? "No title")
                    .font(.system(size: 20))
                    .lineLimit(1)

                HStack {
                    ForEach(anime.genres?.prefix(3) ?? [], id: \.self) { genre in
                        Text(genre!)
                            .font(.system(size: 10))
                            .padding(3)
                            .background(Color("AppColor").opacity(0.4))
                            .clipShape(.capsule)
                    }
                }

                TextUtility.cleanDescription(anime.description ?? "")
                    .lineLimit(4)
                    .font(.system(size: 10))
                    .padding(.vertical, 5)
            }
        }
        .padding(5)
    }
}
