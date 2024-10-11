//
//  CharacterServiceProtocol.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 8.10.2024.
//

import AnilistAPI
import Foundation

protocol CharacterServiceProtocol {
    func getCharacters(page: Int) async throws -> [CharacterSmall]?
    func searchCharacter(search: String) async throws -> [CharacterSmall]?
    func getCharacterDetail(id: Int) async throws -> CharacterFull?
}
