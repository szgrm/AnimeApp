//
//  CharacterDetailViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 3.08.2024.
//

import AnilistAPI
import Foundation

class CharacterDetailViewModel: ObservableObject {
    private let characterService: CharacterService
    @Published public var characterDetail: CharacterDetail?
    @Published public var loadingState: LoadingState = .loading
    var characterID: Int

    init(characterID: Int, characterService: CharacterService) {
        self.characterID = characterID
        self.characterService = characterService
    }

    @MainActor
    func getCharacterDetail() async {
        do {
            characterDetail = try await characterService.getCharacterDetail(id: characterID)
            loadingState = .loaded
        } catch {
            loadingState = .error(error)
        }
    }
}
