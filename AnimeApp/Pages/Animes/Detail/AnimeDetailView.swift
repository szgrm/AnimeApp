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

            switch vm.loadingState {
            case .loading:
                KikiLoadingView(height: 100, size: 16)
                    .task { await vm.getAnimeDetail() }
            case .loaded:
                AnimeDetailContentView(animeDetail: vm.animeDetail!)
            case .error:
                Text("Error")
                    .foregroundStyle(.secondary)
            case .noResult:
                NoResultView()
            }
        }

        .ignoresSafeArea()
    }
}

#Preview {
    AnimeDetailView(animeID: 6)
}
