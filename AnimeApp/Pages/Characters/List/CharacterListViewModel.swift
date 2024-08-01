//
//  CharacterListViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 31.07.2024.
//

import AnilistAPI
import Combine
import Foundation
import OSLog

class CharacterListViewModel: ObservableObject {
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
        getCharacters()
        searchCancellable = searchSubject.eraseToAnyPublisher()
            .map {
                $0
            }
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink(receiveValue: { [weak self] searchText in
                self?.searchCharacter(search: searchText)
            })
    }

    func loadMore() {
        currentPage += 1
        getCharacters()
    }

    func getCharacters() {
        Network.shared.apollo.fetch(query: GetCharactersQuery(page: currentPage)) { result in
            switch result {
            case let .success(graphQLResult):
                let newCharacters = graphQLResult.data?.page?.characters?.compactMap { $0?.fragments.characterSmall }
                self.characters?.append(contentsOf: newCharacters ?? [])
                self.hasNextPage = graphQLResult.data?.page?.pageInfo?.hasNextPage ?? false
            case let .failure(error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }

    func refresh() {
        Network.shared.apollo.fetch(query: GetCharactersQuery(page: 1)) { result in
            switch result {
            case let .success(graphQLResult):
                let newCharacters = graphQLResult.data?.page?.characters?.compactMap { $0?.fragments.characterSmall }
                self.characters = newCharacters
                self.hasNextPage = graphQLResult.data?.page?.pageInfo?.hasNextPage ?? false
            case let .failure(error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }

    func searchCharacter(search: String) {
        Network.shared.apollo.fetch(query: SearchCharacterQuery(search: search)) { result in
            switch result {
            case let .success(graphQLResult):
                let characterResult = graphQLResult.data?.page?.characters?.compactMap { $0?.fragments.characterSmall }
                self.characters = characterResult
                self.hasNextPage = false
            case let .failure(error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }
}
