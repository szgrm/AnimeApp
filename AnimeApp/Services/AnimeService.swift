//
//  AnimeService.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 6.08.2024.
//

import AnilistAPI
import OSLog

class AnimeService {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AnimeService.self)
    )

    func getAnimes(page: Int) async -> [AnimeSmall]? {
        await withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: GetAnimesQuery(page: page)) { result in
                switch result {
                case let .success(graphQLResult):
                    let animes = graphQLResult.data?.page?.media?.compactMap { $0?.fragments.animeSmall }
                    continuation.resume(returning: animes)
                case let .failure(error):
                    self.logger.debug("error: \(error.localizedDescription)")
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    func searchAnimes(search: String) async -> [AnimeSmall]? {
        await withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: SearchAnimeQuery(search: search)) { result in
                switch result {
                case let .success(graphQLResult):
                    let animes = graphQLResult.data?.page?.media?.compactMap { $0?.fragments.animeSmall }
                    continuation.resume(returning: animes)
                case let .failure(error):
                    self.logger.debug("error: \(error.localizedDescription)")
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    func getAnimeDetail(id: Int) async -> AnimeFull? {
        await withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: GetAnimeDetailQuery(id: id)) { result in
                switch result {
                case let .success(graphQLResult):
                    let animeDetail = graphQLResult.data?.media?.fragments.animeFull
                    continuation.resume(returning: animeDetail)
                case let .failure(error):
                    self.logger.debug("error: \(error.localizedDescription)")
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}
