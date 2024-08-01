//
//  AnimeListViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import AnilistAPI
import Combine
import Foundation
import OSLog

class AnimeListViewModel: ObservableObject {
    @Published public var animes: [AnimeSmall]? = []
    @Published public var hasNextPage: Bool = false
    @Published public var searchTerm: String = "" {
        willSet {
            DispatchQueue.main.async {
                self.searchSubject.send(newValue)
            }
        }
        didSet {
            guard !searchTerm.isEmpty else {
                refresh()
                return
            }
        }
    }

    private let searchSubject = PassthroughSubject<String, Never>()
    private var searchCancellable: AnyCancellable? {
        didSet {
            oldValue?.cancel()
        }
    }

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AnimeListViewModel.self)
    )

    var currentPage: Int = 1

    init() {
        getAnimes()
        searchCancellable = searchSubject.eraseToAnyPublisher()
            .map {
                $0
            }
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink(receiveValue: { [weak self] searchText in
                self?.searchAnime(search: searchText)
            })
    }

    func loadMore() {
        currentPage += 1
        getAnimes()
    }

    func getAnimes() {
        Network.shared.apollo.fetch(query: GetAnimesQuery(page: currentPage)) { result in
            switch result {
            case let .success(graphQLResult):
                let newAnimes = graphQLResult.data?.page?.media?.compactMap { $0?.fragments.animeSmall }
                self.animes?.append(contentsOf: newAnimes ?? [])
                self.hasNextPage = graphQLResult.data?.page?.pageInfo?.hasNextPage ?? false
            case let .failure(error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }

    func refresh() {
        Network.shared.apollo.fetch(query: GetAnimesQuery(page: 1)) { result in
            switch result {
            case let .success(graphQLResult):
                let newAnimes = graphQLResult.data?.page?.media?.compactMap { $0?.fragments.animeSmall }
                self.animes = newAnimes
                self.hasNextPage = graphQLResult.data?.page?.pageInfo?.hasNextPage ?? false
            case let .failure(error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }

    func searchAnime(search: String) {
        Network.shared.apollo.fetch(query: SearchAnimeQuery(search: search)) { result in
            switch result {
            case let .success(qraphQLResult):
                let animeResults = qraphQLResult.data?.page?.media?.compactMap { $0?.fragments.animeSmall }
                self.animes = animeResults
                self.hasNextPage = false
            case let .failure(error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }
}
