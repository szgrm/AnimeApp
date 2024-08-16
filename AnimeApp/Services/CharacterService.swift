//
//  CharacterService.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 7.08.2024.
//

import AnilistAPI
import OSLog

class CharacterService {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AnimeService.self)
    )

    func getCharacters(page: Int) async -> [CharacterSmall]? {
        await withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: GetCharactersQuery(page: page)) { result in
                switch result {
                case let .success(graphQLResult):
                    let characters = graphQLResult.data?.page?.characters?.compactMap { $0?.fragments.characterSmall }
                    continuation.resume(returning: characters)

                case let .failure(error):
                    self.logger.debug("error: \(error.localizedDescription)")
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    func searchCharacter(search: String) async -> [CharacterSmall]? {
        await withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: SearchCharacterQuery(search: search)) { result in
                switch result {
                case let .success(graphQLResult):
                    let characters = graphQLResult.data?.page?.characters?.compactMap { $0?.fragments.characterSmall }
                    continuation.resume(returning: characters)

                case let .failure(error):
                    self.logger.debug("error: \(error.localizedDescription)")
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    func getCharacterDetail(id: Int) async -> CharacterFull? {
        await withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: GetCharacterDetailQuery(id: id), cachePolicy: .fetchIgnoringCacheData) { result in
                switch result {
                case let .success(graphQLResult):
                    let characterDetail = graphQLResult.data?.character?.fragments.characterFull
                    continuation.resume(returning: characterDetail)

                case let .failure(error):
                    self.logger.debug("error: \(error.localizedDescription)")
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}
