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
    @Published public var characters: [CharacterSmall]? = []
    @Published public var hasNextPage: Bool = false
    @Published public var searchTerm: String = "" {
        willSet {
            DispatchQueue.main.async {
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
        let newCharacters = await characterService.getCharacters(page: currentPage)
        characters?.append(contentsOf: newCharacters ?? [])
        hasNextPage = true
    }

    func refresh() async {
        characters = await characterService.getCharacters(page: 1)
        hasNextPage = true
    }

    func searchCharacter(search: String) async {
        characters = await characterService.searchCharacter(search: search)
        hasNextPage = false
    }
}
