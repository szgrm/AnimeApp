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
    @ObservedObject var vm: CharacterDetailViewModel
    let characterID: Int

    init(characterID: Int) {
        self.characterID = characterID
        vm = CharacterDetailViewModel(characterID: characterID, characterService: CharacterService())
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("AppColor"), Color("Background"), Color("Background"), Color("Background")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            switch vm.loadingState {
            case .loading:
                KikiLoadingView(height: 100, size: 16)
                    .task { await vm.getCharacterDetail() }
            case .loaded:
                CharacterDetailContentView(characterDetail: vm.characterDetail!)
            case .error:
                Text("Error")
                    .foregroundStyle(.secondary)
            case .noResult:
                NoResultView()
            }
        }
    }
}

#Preview {
    CharacterDetailView(characterID: 1)
}
