//
//  CharacterDetailViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 3.08.2024.
//

import AnilistAPI
import Foundation
import OSLog

class CharacterDetailViewModel: ObservableObject {
    @Published public var characterDetail: CharacterFull?
    var characterID: Int

    var alternativeNamesFormatted: String? {
        guard let alternative = characterDetail?.name?.alternative else { return nil }
        return alternative.compactMap { $0 }.joined(separator: ", ")
    }

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AnimeListViewModel.self)
    )

    init(characterID: Int) {
        self.characterID = characterID
    }

    func getCharacterDetail() {
        Network.shared.apollo.fetch(query: GetCharacterDetailQuery(id: characterID)) { result in
            switch result {
            case let .success(graphQLResult):
                self.characterDetail = graphQLResult.data?.character?.fragments.characterFull
            case let .failure(error):
                self.logger.debug("error: \(error.localizedDescription)")
            }
        }
    }

    func parseHeight(from text: String) -> String {
        if let heightRange = text.range(of: "__Height:__") {
            let substring = text[heightRange.upperBound...]
            if let endOfLineRange = substring.range(of: "\n") {
                let heightValue = substring[..<endOfLineRange.lowerBound]
                return String(heightValue).trimmingCharacters(in: .whitespaces)
            }
        }
        return "-"
    }

    func formatDate(date: CharacterFull.DateOfBirth?) -> String {
        var dateComponents = DateComponents()
        dateComponents.day = date?.day
        dateComponents.month = date?.month
        dateComponents.year = date?.year

        let calendar = Calendar.current
        guard let dateCalendar = calendar.date(from: dateComponents) else { return "" }

        let dateFormatter = DateFormatter()
        if date?.year != nil {
            dateFormatter.dateFormat = "d MMMM yyyy"
            return dateFormatter.string(from: dateCalendar)
        } else {
            dateFormatter.dateFormat = "d MMMM"
            return dateFormatter.string(from: dateCalendar)
        }
    }
}
