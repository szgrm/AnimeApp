//
//  Anime.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 20.08.2024.
//

import AnilistAPI
import Foundation

struct Anime: Identifiable {
    let id: Int
    let isAdult: Bool
    let coverImage: AnimeCoverImage
    let title: AnimeTitle
    let genres: [String]
    let description: String
    let format: MediaFormat
    let seasonYear: String

    init(from anime: AnimeSmall) {
        id = anime.id
        isAdult = anime.isAdult ?? true
        coverImage = AnimeCoverImage(large: (anime.coverImage?.large)!)
        title = AnimeTitle(english: anime.title?.english, romaji: anime.title?.romaji)
        genres = anime.genres?.compactMap { $0 } ?? []
        description = anime.description ?? ""
        format = (anime.format?.value)!
        seasonYear = if let year = anime.seasonYear { "\(year)" } else { "-" }
    }
}

struct AnimeCoverImage {
    let large: String
}

struct AnimeTitle {
    let english: String?
    let romaji: String?
}
