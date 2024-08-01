//
//  TabbarView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            AnimeListView()
                .tabItem {
                    Label("Animes", systemImage: "display")
                }
            CharacterListView()
                .tabItem {
                    Label("Characters", systemImage: "person.crop.square.filled.and.at.rectangle")
                }
        }
        .tint(Color("AppColor"))
    }
}

#Preview {
    TabbarView()
}
