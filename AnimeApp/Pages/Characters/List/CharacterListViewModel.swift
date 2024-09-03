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
    @Published public var viewState: ViewState<[Characters]> = .loading
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

    init(characterService: CharacterService) {
        self.characterService = characterService
        Task { await getCharacters() }
        searchCancellable = searchSubject.eraseToAnyPublisher()
            .map { $0 }
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
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
        let newCharactersData = await characterService.getCharacters(page: currentPage)
        let newCharacters = newCharactersData?.compactMap { Characters(from: $0) } ?? []
        if case let .loaded(characters) = viewState {
            viewState = .loaded(characters + newCharacters)
        } else {
            viewState = .loaded(newCharacters)
        }
        hasNextPage = true
    }

    func refresh() async {
        let charactersData = await characterService.getCharacters(page: 1)
        let characters = charactersData?.compactMap { Characters(from: $0) } ?? []
        hasNextPage = true
        viewState = .loaded(characters)
    }

    func searchCharacter(search: String) async {
        let charactersData = await characterService.searchCharacter(search: search)
        let characters = charactersData?.compactMap { Characters(from: $0) } ?? []
        hasNextPage = false
        viewState = characters.isEmpty == false ? .loaded(characters) : .noResult
    }
}
