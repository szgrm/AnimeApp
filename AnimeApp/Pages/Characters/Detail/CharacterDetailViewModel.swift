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
    @Published public var viewState: ViewState<CharacterDetail> = .loading
    var characterID: Int

    init(characterID: Int, characterService: CharacterService) {
        self.characterID = characterID
        self.characterService = characterService
    }

    @MainActor
    func getCharacterDetail() async {
        do {
            let characterDetailData = try await characterService.getCharacterDetail(id: characterID)
            let characterDetail = CharacterDetail(from: characterDetailData!)
            viewState = .loaded(characterDetail)
        } catch {
            viewState = .error(error)
        }
    }
}
