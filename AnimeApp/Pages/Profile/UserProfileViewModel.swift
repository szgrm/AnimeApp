//
//  UserProfileViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 29.10.2024.
//

import AnilistAPI
import Foundation

class UserProfileViewModel: ObservableObject {
    private let userService: UserServiceProtocol
    @Published public var viewState: ViewState<UserInfo> = .initial

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    @MainActor
    func getUserInfo() async {
        do {
            let userInfoDTO = try await userService.getUser()!
            let userInfo = UserInfo(from: userInfoDTO)
            viewState = .loaded(userInfo)
        } catch {
            viewState = .error(error)
        }
    }
}
