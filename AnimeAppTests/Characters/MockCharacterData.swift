//
//  MockCharacterData.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 11.10.2024.
//

import AnilistAPI
import Foundation

enum MockCharacterData {
    static let characterData: [String: Any] = [
        "__typename": "Character",
        "id": 127_691,
        "name": [
            "__typename": "CharacterName",
            "full": "Satoru Gojou"
        ],
        "image": [
            "__typename": "CharacterImage",
            "large": "https://s4.anilist.co/file/anilistcdn/character/large/b127691-UmAY8k2uXeQM.png"
        ]
    ]

    static func mockCharacterSmall() throws -> CharacterSmall {
        return try CharacterSmall(data: characterData)
    }

    static let characterDetailsData: [String: Any] = [
        "__typename": "Character",
        "id": 1,
        "name": [
            "__typename": "CharacterName",
            "full": "Spike Spiegel",
            "alternative": [
                "Spike Spike",
                "Swimming Bird"
            ]
        ],
        "image": [
            "__typename": "CharacterImage",
            "large": "https://s4.anilist.co/file/anilistcdn/character/large/b1-ChxaldmieFlQ.png"
        ],
        "age": "27",
        "gender": "Male",
        "description": "__Height:__ 185 cm   \n\nSpike Spiegel is a tall and lean 27-year-old bounty hunter born on Mars.",
        "bloodType": "A",
        "dateOfBirth": [
            "__typename": "FuzzyDate",
            "day": 26,
            "month": 6,
            "year": 2044
        ],
        "media": [
            "__typename": "MediaConnection",
            "nodes": [
                [
                    "__typename": "Media",
                    "id": 1,
                    "isAdult": false,
                    "coverImage": [
                        "__typename": "MediaCoverImage",
                        "large": "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx1-CXtrrkMpJ8Zq.png"
                    ],
                    "title": [
                        "__typename": "MediaTitle",
                        "english": "Cowboy Bebop",
                        "romaji": "Cowboy Bebop"
                    ],
                    "genres": [
                        "Action",
                        "Adventure",
                        "Drama",
                        "Sci-Fi"
                    ],
                    "description": "Enter a world in the distant future...",
                    "format": "TV",
                    "seasonYear": 1998
                ]
            ]
        ]
    ]

    static func mockCharacterFull() throws -> CharacterFull {
        return try CharacterFull(data: characterData)
    }
}
