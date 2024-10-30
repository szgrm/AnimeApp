//
//  UserLoginViewModel.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 23.10.2024.
//

import AuthenticationServices
import Foundation

class UserLoginViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for _: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }

    private let clientId = "21888"
    private let anilistAuthURL = "https://anilist.co/api/v2/oauth/authorize"

    func login() {
        let authSession = ASWebAuthenticationSession(
            url: URL(string: "\(anilistAuthURL)?client_id=\(clientId)&response_type=token")!,
            callbackURLScheme: "animeapp"
        ) { url, error in
            if let error = error {
                print(error)
                return
            } else if let url = url {
                self.processResponseUrl(url: url)
            }
        }

        authSession.presentationContextProvider = self
        authSession.prefersEphemeralWebBrowserSession = true
        authSession.start()
    }

    private func processResponseUrl(url: URL) {
        let anilistComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)

        if let anilistFragment = anilistComponents?.fragment,
           let dummyURL = URL(string: "http://dummyurl.com?\(anilistFragment)"),
           let components = URLComponents(url: dummyURL, resolvingAgainstBaseURL: true),
           let queryItems = components.queryItems,
           let token = queryItems.first(where: { $0.name == "access_token" })?.value
        {
            KeychainUtil.shared.keychain.set(token, forKey: "accessToken")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
        }
    }
}
