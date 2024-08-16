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
    @Published public var characterDetail: CharacterFull?
    @Published public var loadingState: LoadingState = .loading
    var characterID: Int

    init(characterID: Int, characterService: CharacterService) {
        self.characterID = characterID
        self.characterService = characterService
    }

    @MainActor
    func getCharacterDetail() async {
        characterDetail = await characterService.getCharacterDetail(id: characterID)
        loadingState = characterDetail != nil ? .loaded : .error
    }

    var alternativeNamesFormatted: String? {
        guard let alternative = characterDetail?.name?.alternative else { return nil }
        return alternative.compactMap { $0 }.joined(separator: ", ")
    }
}
