//
//  CharacterListViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 31.07.2024.
//

import AnilistAPI
import Combine
import Foundation

@MainActor
class CharacterListViewModel: ObservableObject {
    private let characterService: CharacterService
    @Published public var hasNextPage: Bool = false
    @Published public var viewState: ViewState<[Characters]> = .initial
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

    init(characterService: CharacterService) {
        self.characterService = characterService
        Task { await getCharacters() }
        searchCancellable = $searchTerm
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .dropFirst()
            .filter { !$0.isEmpty }
            .sink(receiveValue: { [weak self] searchText in
                Task { await self?.searchCharacter(search: searchText) }
            })
    }

    func loadMore() async {
        currentPage += 1
        await getCharacters()
    }

    func getCharacters() async {
        do {
            let newCharactersData = try await characterService.getCharacters(page: currentPage)
            let newCharacters = newCharactersData?.compactMap { Characters(from: $0) } ?? []
            if case let .loaded(characters) = viewState {
                viewState = .loaded(characters + newCharacters)
            } else {
                viewState = .loaded(newCharacters)
            }
            hasNextPage = true
        } catch {
            viewState = .error(error)
        }
    }

    func refresh() async {
        do {
            let charactersData = try await characterService.getCharacters(page: 1)
            let characters = charactersData?.compactMap { Characters(from: $0) } ?? []
            hasNextPage = true
            viewState = .loaded(characters)
        } catch {
            viewState = .error(error)
        }
    }

    func searchCharacter(search: String) async {
        do {
            let charactersData = try await characterService.searchCharacter(search: search)
            let characters = charactersData?.compactMap { Characters(from: $0) } ?? []
            hasNextPage = false
            viewState = characters.isEmpty == false ? .loaded(characters) : .noResult
        } catch {
            viewState = .error(error)
        }
    }
}
