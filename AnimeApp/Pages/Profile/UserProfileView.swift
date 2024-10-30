//
//  UserProfileView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 29.10.2024.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    init() {
        viewModel = UserProfileViewModel(userService: UserService())
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(edges: .all)

                if isLoggedIn {
                    switch viewModel.viewState {
                    case let .loaded(userInfo):
                        UserProfileContentView(userInfo: userInfo)
                    case let .error(error):
                        ErrorView(error: error)
                    default: KikiLoadingView(height: 100, size: 16)
                        .task { await viewModel.getUserInfo() }
                    }
                } else {
                    UserLoginView()
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    UserProfileView()
}
