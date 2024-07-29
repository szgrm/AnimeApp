//
//  AnimeDetailViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 18.07.2024.
//

import AnilistAPI
import Foundation
import OSLog

class AnimeDetailViewModel: ObservableObject {
    @Published public var animeDetail: AnimeFull?
    var animeID: Int

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AnimeListViewModel.self)
    )

    init(animeID: Int) {
        self.animeID = animeID
    }

    func getAnimeDetail() {
        Network.shared.apollo.fetch(query: GetAnimeDetailQuery(id: animeID)) { result in
            switch result {
            case let .success(graphQLResult):
                self.animeDetail = graphQLResult.data?.media?.fragments.animeFull

            case let .failure(error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }
}
