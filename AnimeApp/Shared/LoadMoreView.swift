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
            KikiLoadingView()
                .frame(width: 100, height: 50)
        }
        .task {
            await loader()
        }
    }
}
