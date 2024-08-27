//
//  AnimeDetail.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 20.08.2024.
//

import AnilistAPI
import Foundation

struct AnimeDetail: Identifiable {
    let id: Int
    let coverImage: AnimeDetailCoverImage
    let title: AnimeDetailTitle
    let genres: [String?]
    let averageScore: String
    let description: String
    let episodes: String
    let characters: [Characters]?
    let seasonYear: String
    let status: MediaStatus
    let trailer: AnimeTrailer?
    let format: MediaFormat
    let bannerImage: String?

    init(from animeDetail: AnimeFull) {
        id = animeDetail.id
        coverImage = AnimeDetailCoverImage(extraLarge: animeDetail.coverImage?.extraLarge ?? "", color: animeDetail.coverImage?.color)
        title = AnimeDetailTitle(english: animeDetail.title?.english, native: animeDetail.title?.native, romaji: animeDetail.title?.romaji)
        genres = animeDetail.genres ?? []
        averageScore = if let score = animeDetail.averageScore { "\(score)%" } else { "-" }
        description = animeDetail.description ?? ""
        episodes = if let episodes = animeDetail.episodes { "\(episodes)" } else { "-" }
        characters = animeDetail.characters?.nodes?.compactMap { Characters(from: ($0?.fragments.characterSmall)!) }
        seasonYear = if let year = animeDetail.seasonYear { "\(year)" } else { "-" }
        status = (animeDetail.status?.value)!
        trailer = AnimeTrailer(id: animeDetail.trailer?.id, site: animeDetail.trailer?.site, thumbnail: animeDetail.trailer?.thumbnail)
        format = (animeDetail.format?.value) ?? MediaFormat.special
        bannerImage = animeDetail.bannerImage
    }
}

struct AnimeDetailCoverImage {
    let extraLarge: String
    let color: String?
}

struct AnimeDetailTitle {
    let english: String?
    let native: String?
    let romaji: String?
}

struct Character {
    let id: Int
    let name: String
    let image: String
    let role: String
}

struct AnimeTrailer {
    let id: String?
    let site: String?
    let thumbnail: String?
}
