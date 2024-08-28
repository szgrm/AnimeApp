//
//  CharacterDetail.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 21.08.2024.
//

import AnilistAPI
import Foundation

struct CharacterDetail {
    let id: Int
    let name: CharacterDetailName
    let image: CharacterDetailImage
    let age: String
    let gender: String
    let description: String
    let bloodType: String
    let dateOfBirth: DateOfBirth
    let media: [Anime]?

    init(from characterDetail: CharacterFull) {
        id = characterDetail.id
        name = CharacterDetailName(full: characterDetail.name?.full ?? "", alternative: characterDetail.name?.alternative)
        image = CharacterDetailImage(large: (characterDetail.image?.large)!)
        age = characterDetail.age ?? "-"
        gender = characterDetail.gender ?? "-"
        description = characterDetail.description ?? ""
        bloodType = characterDetail.bloodType ?? "-"
        dateOfBirth = DateOfBirth(year: characterDetail.dateOfBirth?.year, month: characterDetail.dateOfBirth?.month, day: characterDetail.dateOfBirth?.day)
        media = characterDetail.media?.nodes?.compactMap { Anime(from: ($0?.fragments.animeSmall)!) }
    }

    var alternativeNamesFormatted: String? {
        guard let alternative = name.alternative else { return nil }
        return alternative.compactMap { $0 }.joined(separator: ", ")
    }
}

struct CharacterDetailName {
    let full: String?
    let alternative: [String?]?
}

struct CharacterDetailImage {
    let large: String
}

struct DateOfBirth {
    let year: Int?
    let month: Int?
    let day: Int?
}
