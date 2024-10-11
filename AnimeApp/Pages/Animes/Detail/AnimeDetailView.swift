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
    @ObservedObject var viewModel: AnimeDetailViewModel

    init(animeID: Int) {
        self.animeID = animeID
        viewModel = AnimeDetailViewModel(animeID: animeID, animeService: AnimeService())
    }

    var body: some View {
        ZStack {
            Color("Background")

            switch viewModel.viewState {
            case .initial:
                KikiLoadingView(height: 100, size: 16)
                    .task { await viewModel.getAnimeDetail() }
            case .loading:
                KikiLoadingView(height: 100, size: 16)
            case let .loaded(animeDetail):
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
