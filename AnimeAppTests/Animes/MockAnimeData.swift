//
//  MockAnimeData.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 11.10.2024.
//

import AnilistAPI
import Foundation

enum MockAnimeData {
    static let animeData: [String: Any] = [
        "__typename": "Media",
        "id": 16498,
        "isAdult": false,
        "coverImage": [
            "__typename": "MediaCoverImage",
            "large": "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx16498-73IhOXpJZiMF.jpg"
        ],
        "title": [
            "__typename": "MediaTitle",
            "english": "Attack on Titan",
            "romaji": "Shingeki no Kyojin"
        ],
        "genres": [
            "Action",
            "Drama",
            "Fantasy",
            "Mystery"
        ],
        "description": "Several hundred years ago, humans were nearly exterminated by titans... ",
        "format": "TV",
        "seasonYear": 2013
    ]

    static func mockAnimeSmall() throws -> AnimeSmall {
        return try AnimeSmall(data: animeData)
    }

    static let animeDetailData: [String: Any] = [
        "__typename": "Media",
        "id": 1,
        "coverImage": [
            "__typename": "MediaCoverImage",
            "extraLarge": "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx1-CXtrrkMpJ8Zq.png",
            "color": "#f1785d"
        ],
        "title": [
            "__typename": "MediaTitle",
            "english": "Cowboy Bebop",
            "native": "カウボーイビバップ",
            "romaji": "Cowboy Bebop"
        ],
        "genres": [
            "Action",
            "Adventure",
            "Drama",
            "Sci-Fi"
        ],
        "averageScore": 86,
        "description": "Enter a world in the distant future...",
        "episodes": 26,
        "characters": [
            "__typename": "CharacterConnection",
            "nodes": [
                [
                    "__typename": "Character",
                    "id": 1,
                    "name": [
                        "__typename": "CharacterName",
                        "full": "Spike Spiegel"
                    ],
                    "image": [
                        "__typename": "CharacterImage",
                        "large": "https://s4.anilist.co/file/anilistcdn/character/large/b1-ChxaldmieFlQ.png"
                    ]
                ]
            ]
        ],
        "seasonYear": 1998,
        "status": "FINISHED",
        "trailer": [
            "__typename": "MediaTrailer",
            "site": "youtube",
            "thumbnail": "https://i.ytimg.com/vi/OhNwckCLzis/hqdefault.jpg",
            "id": "OhNwckCLzis"
        ],
        "format": "TV",
        "bannerImage": "https://s4.anilist.co/file/anilistcdn/media/anime/banner/1-OquNCNB6srGe.jpg"
    ]

    static func mockAnimeFull() throws -> AnimeFull {
        return try AnimeFull(data: animeDetailData)
    }
}
