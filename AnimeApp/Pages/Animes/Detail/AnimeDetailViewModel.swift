//
//  AnimeDetailViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 18.07.2024.
//

import AnilistAPI
import Foundation

class AnimeDetailViewModel: ObservableObject {
    private let animeService: AnimeServiceProtocol
    @Published public var viewState: ViewState<AnimeDetail> = .initial
    var animeID: Int

    init(animeID: Int, animeService: AnimeServiceProtocol) {
        self.animeID = animeID
        self.animeService = animeService
    }

    @MainActor
    func getAnimeDetail() async {
        do {
            let animeDetailData = try await animeService.getAnimeDetail(id: animeID)
            let animeDetail = AnimeDetail(from: animeDetailData!)
            viewState = .loaded(animeDetail)
        } catch {
            viewState = .error(error)
        }
    }
}
