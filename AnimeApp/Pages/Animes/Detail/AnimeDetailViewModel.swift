//
//  AnimeDetailViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 18.07.2024.
//

import Foundation
import AnilistAPI
import OSLog

class AnimeDetailViewModel: ObservableObject {
    @Published public var animeDetail: GetAnimeDetailQuery.Data.Media?
    var animeID: Int
    
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AnimeListViewModel.self)
    )
    
    init(animeID: Int){
        self.animeID = animeID
    }
    
    func getAnimeDetail() {
        Network.shared.apollo.fetch(query: GetAnimeDetailQuery(id: .some(animeID))) { result in
            switch result {
            case .success(let graphQLResult):
                self.animeDetail = graphQLResult.data?.media // sor
                
            case .failure(let error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }
}


