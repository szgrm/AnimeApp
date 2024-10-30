//
//  UserSettingsView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 30.10.2024.
//

import SwiftUI

struct UserSettingsView: View {
    var body: some View {
        Button("Logout") {
            KeychainUtil.shared.keychain.delete("accessToken")
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
        }
    }
}

#Preview {
    UserSettingsView()
}
