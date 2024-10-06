//
//  MockAnimeService.swift
//  AnimeAppTests
//
//  Created by Sezgi İrem İlgar on 20.09.2024.
//

import AnilistAPI
@testable import AnimeApp
import Foundation

class MockAnimeService: AnimeServiceProtocol {
    var getAnimesResult: Result<[AnimeSmall], Error>?
    var searchAnimesResult: Result<[AnimeSmall], Error>?
    var getAnimeDetailResult: Result<AnimeFull, Error>?

    func getAnimes(page _: Int) async throws -> [AnimeSmall]? {
        guard let result = getAnimesResult else {
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "getAnimesResult not set"])
        }
        return try result.get()
    }

    func searchAnimes(search _: String) async throws -> [AnimeSmall]? {
        guard let result = searchAnimesResult else {
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "searchAnimesResult not set"])
        }
        return try result.get()
    }

    func getAnimeDetail(id _: Int) async throws -> AnimeFull? {
        guard let result = getAnimeDetailResult else {
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "getAnimeDetailResult not set"])
        }
        return try result.get()
    }
}
