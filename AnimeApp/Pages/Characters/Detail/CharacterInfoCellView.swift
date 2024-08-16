//
//  CharacterInfoCellView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 3.08.2024.
//

import SwiftUI

struct CharacterInfoCellView: View {
    var cellTitle: LocalizedStringKey
    var cellVariable: String
    var body: some View {
        VStack {
            Text(cellTitle)
                .customFont(.regular, 16)
                .foregroundStyle(.secondary)
            Text(cellVariable)
                .customFont(.regular, 14)
        }
    }
}
