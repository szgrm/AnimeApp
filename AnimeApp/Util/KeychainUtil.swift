//
//  KeychainUtil.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 23.10.2024.
//

import Foundation
import KeychainSwift

class KeychainUtil {
    static let shared = KeychainUtil()

    private(set) lazy var keychain: KeychainSwift = {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        return keychain
    }()
}
