//
//  Characters.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 21.08.2024.
//

import AnilistAPI
import Foundation

struct Characters: Identifiable {
    let id: Int
    let name: CharacterName
    let image: CharacterImage

    init(from character: CharacterSmall) {
        id = character.id
        name = CharacterName(full: character.name?.full ?? "-")
        image = CharacterImage(large: (character.image?.large)!)
    }
}

struct CharacterName {
    let full: String
}

struct CharacterImage {
    let large: String
}
