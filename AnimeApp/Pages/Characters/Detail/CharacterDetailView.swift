//
//  CharacterDetailView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 31.07.2024.
//

import AnilistAPI
import NukeUI
import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterSmall
    var body: some View {
        Text("Detail")
            .navigationTitle(character.name?.full ?? "Character Detail")
            .navigationBarTitleDisplayMode(.inline)
    }
}
