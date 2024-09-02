//
//  AnimeDetailView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import AnilistAPI
import NukeUI
import SwiftUI

struct AnimeDetailView: View {
    let animeID: Int
    @ObservedObject var vm: AnimeDetailViewModel

    init(animeID: Int) {
        self.animeID = animeID
        vm = AnimeDetailViewModel(animeID: animeID, animeService: AnimeService())
    }

    var body: some View {
        ZStack {
            Color("Background")

            switch vm.viewState {
            case .loading:
                KikiLoadingView(height: 100, size: 16)
                    .task { await vm.getAnimeDetail() }
            case .loaded(let animeDetail):
                AnimeDetailContentView(animeDetail: animeDetail)
            case let .error(error):
                ErrorView(error: error)
            case .noResult:
                NoResultView()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AnimeDetailView(animeID: 1)
}
