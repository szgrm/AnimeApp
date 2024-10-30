//
//  UserLoginView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 20.10.2024.
//

import SwiftUI
import WebKit

struct UserLoginView: View {
    @StateObject private var viewModel = UserLoginViewModel()
    var body: some View {
        VStack {
            Text("loginText")
                .customFont(.regular, 14)
                .frame(width: 300)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(10)

            Button(
                action: {
                    viewModel.login()
                },
                label: {
                    Text("Login")
                        .customFont(.regular, 20)
                        .padding(3)
                        .frame(width: 100, height: 40)
                        .foregroundColor(.white)
                        .background(Color("AppColor"))
                        .cornerRadius(10)
                }
            )
        }
    }
}

#Preview {
    UserLoginView()
}
