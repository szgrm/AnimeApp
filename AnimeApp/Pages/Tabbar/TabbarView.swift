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
            Tab("Animes", systemImage: "display") {
                AnimeListView()
            }
            Tab("Characters", systemImage: "person.crop.square.filled.and.at.rectangle") {
                CharacterListView()
            }
            Tab("Profile", systemImage: "person.fill") {
                UserProfileView()
            }
        }
        .tint(Color("AppColor"))
    }
}

#Preview {
    TabbarView()
}
