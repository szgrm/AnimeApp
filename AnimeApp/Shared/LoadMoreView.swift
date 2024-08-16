//
//  LoadMoreView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 16.08.2024.
//

import SwiftUI

struct LoadMoreView: View {
    var loader: () async -> Void
    var body: some View {
        HStack {
            KikiLoadingView(height: 50, size: 12)
        }
        .task {
            await loader()
        }
    }
}
