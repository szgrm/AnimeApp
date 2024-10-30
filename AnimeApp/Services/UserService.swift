//
//  UserService.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 29.10.2024.
//

import AnilistAPI
import Foundation
import OSLog

class UserService: UserServiceProtocol {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: UserService.self)
    )

    func getUser() async throws -> UserInfoDTO? {
        try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(query: GetUserInfoQuery()) { result in
                switch result {
                case let .success(graphQLResult):
                    let userInfo = graphQLResult.data?.viewer?.fragments.userInfoDTO
                    continuation.resume(returning: userInfo)
                case let .failure(error):
                    self.logger.debug("error: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
