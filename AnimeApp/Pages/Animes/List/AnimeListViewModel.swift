//
//  AnimeListViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import Foundation
import AnilistAPI
import OSLog

class AnimeListViewModel: ObservableObject {
    @Published public var animes: [GetAnimesQuery.Data.Page.Medium]? = []
    @Published public var hasNextPage: Bool = false
    
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AnimeListViewModel.self)
    )
    
    var currentPage: Int = 1
    
    init() {
        getAnimes()
    }
    
    func loadMore() {
        currentPage += 1
        getAnimes()
    }
    func getAnimes() {
        Network.shared.apollo.fetch(query: GetAnimesQuery(page: .some(currentPage))) { result in
            switch result {
            case .success(let graphQLResult):
                let newAnimes = graphQLResult.data?.page?.media?.compactMap({$0})
                self.animes?.append(contentsOf: newAnimes ?? [])
                self.hasNextPage = graphQLResult.data?.page?.pageInfo?.hasNextPage ?? false
            case .failure(let error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }
    
    func refresh() {
        Network.shared.apollo.fetch(query: GetAnimesQuery(page: .some(1))) { result in
            switch result {
            case .success(let graphQLResult):
                let newAnimes = graphQLResult.data?.page?.media?.compactMap({$0})
                self.animes = newAnimes
                self.hasNextPage = graphQLResult.data?.page?.pageInfo?.hasNextPage ?? false
            case .failure(let error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }
}
