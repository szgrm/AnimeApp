//
//  CharacterService.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 7.08.2024.
//

import AnilistAPI
import OSLog

class CharacterService: CharacterServiceProtocol {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AnimeService.self)
    )

    func getCharacters(page: Int) async throws -> [CharacterSmall]? {
        try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(query: GetCharactersQuery(page: page)) { result in
                switch result {
                case let .success(graphQLResult):
                    let characters = graphQLResult.data?.page?.characters?.compactMap { $0?.fragments.characterSmall }
                    continuation.resume(returning: characters)

                case let .failure(error):
                    self.logger.debug("error: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func searchCharacter(search: String) async throws -> [CharacterSmall]? {
        try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(query: SearchCharacterQuery(search: search)) { result in
                switch result {
                case let .success(graphQLResult):
                    let characters = graphQLResult.data?.page?.characters?.compactMap { $0?.fragments.characterSmall }
                    continuation.resume(returning: characters)

                case let .failure(error):
                    self.logger.debug("error: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getCharacterDetail(id: Int) async throws -> CharacterFull? {
        try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(query: GetCharacterDetailQuery(id: id), cachePolicy: .fetchIgnoringCacheData) { result in
                switch result {
                case let .success(graphQLResult):
                    let characterDetail = graphQLResult.data?.character?.fragments.characterFull
                    continuation.resume(returning: characterDetail)

                case let .failure(error):
                    self.logger.debug("error: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
