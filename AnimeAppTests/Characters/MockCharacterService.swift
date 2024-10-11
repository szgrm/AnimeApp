//
//  MockCharacterService.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 8.10.2024.
//

import AnilistAPI
@testable import AnimeApp
import Foundation

class MockCharacterService: CharacterServiceProtocol {
    var getCharactersResult: Result<[CharacterSmall], Error>?
    var searchCharactersResult: Result<[CharacterSmall], Error>?
    var getCharacterDetailResult: Result<CharacterFull, Error>?

    func getCharacters(page _: Int) async throws -> [CharacterSmall]? {
        guard let result = getCharactersResult else {
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "getCharactersResult not set"])
        }
        return try result.get()
    }

    func searchCharacter(search _: String) async throws -> [CharacterSmall]? {
        guard let result = searchCharactersResult else {
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "searchCharactersResult not set"])
        }
        return try result.get()
    }

    func getCharacterDetail(id _: Int) async throws -> CharacterFull? {
        guard let result = getCharacterDetailResult else {
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "getCharacterDetailResult not set"])
        }
        return try result.get()
    }
}
