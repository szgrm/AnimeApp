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
    @Published public var hasNextPage: Bool = false
    @Published public var viewState: ViewState<[Anime]> = .loading
    @Published public var searchTerm: String = "" {
        willSet {
            DispatchQueue.main.async {
                self.viewState = .loading
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
        let newAnimeData = await animeService.getAnimes(page: currentPage)
        let newAnimes = newAnimeData?.compactMap { Anime(from: $0) } ?? []
        if case let .loaded(animes) = viewState {
            viewState = .loaded(animes + newAnimes)
        } else {
            viewState = .loaded(newAnimes)
        }
        hasNextPage = true
    }

    func refresh() async {
        let animesData = await animeService.getAnimes(page: 1)
        let animes = animesData?.compactMap { Anime(from: $0) } ?? []
        hasNextPage = true
        viewState = .loaded(animes)
    }

    func searchAnime(search: String) async {
        let animesData = await animeService.searchAnimes(search: search)
        let animes = animesData?.compactMap { Anime(from: $0) } ?? []
        hasNextPage = false
        viewState = animes.isEmpty == false ? .loaded(animes) : .noResult
    }
}
