//
//  AnimeInfoCellView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 30.07.2024.
//

import AnilistAPI
import SwiftUI

struct AnimeInfoCellView: View {
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
