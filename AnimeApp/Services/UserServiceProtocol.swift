//
//  UserServiceProtocol.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 29.10.2024.
//

import AnilistAPI
import Foundation

protocol UserServiceProtocol {
    func getUser() async throws -> UserInfoDTO?
}
