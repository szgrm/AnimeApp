//
//  CharacterInfoCellView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 3.08.2024.
//

import SwiftUI

struct CharacterInfoCellView: View {
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
