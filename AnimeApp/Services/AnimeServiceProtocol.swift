//
//  AnimeServiceProtocol.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 20.09.2024.
//

import AnilistAPI
import Foundation

protocol AnimeServiceProtocol {
    func getAnimes(page: Int) async throws -> [AnimeSmall]?
    func searchAnimes(search: String) async throws -> [AnimeSmall]?
    func getAnimeDetail(id: Int) async throws -> AnimeFull?
}
