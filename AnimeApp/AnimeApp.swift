//
//  AnimeApp.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import netfox
import SwiftUI

@main
struct AnimeApp: App {
    init() {
        #if DEBUG
            NFX.sharedInstance().start()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            TabbarView()
        }
    }
}
