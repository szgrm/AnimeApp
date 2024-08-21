//
//  AnimeListViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import AnilistAPI
import Combine
import Foundation

@MainActor
class AnimeListViewModel: ObservableObject {
    private let animeService: AnimeService
    @Published public var animes: [Anime]? = []
    @Published public var hasNextPage: Bool = false
    @Published public var loadingState: LoadingState = .loading
    @Published public var searchTerm: String = "" {
        willSet {
            DispatchQueue.main.async {
                self.loadingState = .loading
                self.searchSubject.send(newValue)
            }
        }
        didSet {
            guard !searchTerm.isEmpty else {
                Task { await refresh() }
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

    var currentPage: Int = 1

    init(animeService: AnimeService) {
        self.animeService = animeService
        Task { await getAnimes() }
        searchCancellable = searchSubject.eraseToAnyPublisher()
            .map { $0 }
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink(receiveValue: { [weak self] searchText in
                Task { await self?.searchAnime(search: searchText) }
            })
    }

    func loadMore() async {
        currentPage += 1
        await getAnimes()
    }

    func getAnimes() async {
        let newAnimes = await animeService.getAnimes(page: currentPage)
        animes?.append(contentsOf: newAnimes ?? [])
        hasNextPage = true
        loadingState = .loaded
    }

    func refresh() async {
        animes = await animeService.getAnimes(page: 1)
        hasNextPage = true
        loadingState = .loaded
    }

    func searchAnime(search: String) async {
        animes = await animeService.searchAnimes(search: search)
        hasNextPage = false
        loadingState = animes?.isEmpty == false ? .loaded : .noResult
    }
}
