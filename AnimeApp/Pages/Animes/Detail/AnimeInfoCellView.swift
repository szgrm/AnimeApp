//
//  AnimeInfoCellView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 30.07.2024.
//

import AnilistAPI
import SwiftUI

struct AnimeInfoCellView: View {
    var cellTitle: String
    var cellVariable: String
    var body: some View {
        VStack {
            Text(cellTitle)
                .foregroundStyle(.secondary)
                .font(.system(size: 14))
            Text(cellVariable)
                .font(.system(size: 14))
        }
    }
}
