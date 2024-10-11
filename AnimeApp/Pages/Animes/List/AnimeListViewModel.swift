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
    private let animeService: AnimeServiceProtocol
    @Published public var hasNextPage: Bool = false
    @Published public var viewState: ViewState<[Anime]> = .initial
    @Published public var searchTerm: String = "" {
        didSet {
            if oldValue != searchTerm, searchTerm.isEmpty {
                Task { await refresh() }
            }
        }
    }

    private var searchCancellable: AnyCancellable? {
        didSet {
            oldValue?.cancel()
        }
    }

    var currentPage: Int = 1

    init(animeService: AnimeServiceProtocol) {
        self.animeService = animeService
        searchCancellable = $searchTerm
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .dropFirst()
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
        do {
            let newAnimeData = try await animeService.getAnimes(page: currentPage)
            let newAnimes = newAnimeData?.compactMap { Anime(from: $0) } ?? []
            if case let .loaded(animes) = viewState {
                viewState = .loaded(animes + newAnimes)
            } else {
                viewState = .loaded(newAnimes)
            }
            hasNextPage = true
        } catch {
            viewState = .error(error)
        }
    }

    func refresh() async {
        do {
            let animesData = try await animeService.getAnimes(page: 1)
            let animes = animesData?.compactMap { Anime(from: $0) } ?? []
            hasNextPage = true
            viewState = .loaded(animes)
        } catch {
            viewState = .error(error)
        }
    }

    func searchAnime(search: String) async {
        do {
            let animesData = try await animeService.searchAnimes(search: search)
            let animes = animesData?.compactMap { Anime(from: $0) } ?? []
            hasNextPage = false
            viewState = animes.isEmpty == false ? .loaded(animes) : .noResult
        } catch {
            viewState = .error(error)
        }
    }
}
