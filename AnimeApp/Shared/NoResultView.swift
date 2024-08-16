//
//  NoResultView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 16.08.2024.
//

import Lottie
import SwiftUI

struct NoResultView: View {
    var body: some View {
        VStack {
            LottieView(animation: .named("noResult"))
                .looping()
                .frame(height: 100)
            Text("No Result.")
                .customFont(.bold, 16)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    NoResultView()
}
