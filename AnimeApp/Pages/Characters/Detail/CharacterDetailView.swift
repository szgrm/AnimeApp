//
//  CharacterDetailView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 31.07.2024.
//

import AnilistAPI
import NukeUI
import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    let characterID: Int

    init(characterID: Int) {
        self.characterID = characterID
        viewModel = CharacterDetailViewModel(characterID: characterID, characterService: CharacterService())
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("AppColor"), Color("Background"), Color("Background"), Color("Background")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            switch viewModel.viewState {
            case .initial:
                KikiLoadingView(height: 100, size: 16)
                    .task { await viewModel.getCharacterDetail() }
            case .loading:
                KikiLoadingView(height: 100, size: 16)
            case let .loaded(characterDetail):
                CharacterDetailContentView(characterDetail: characterDetail)
            case let .error(error):
                ErrorView(error: error)
            case .noResult:
                NoResultView()
            }
        }
    }
}

#Preview {
    CharacterDetailView(characterID: 1)
}
