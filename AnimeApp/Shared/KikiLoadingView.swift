//
//  KikiLoadingView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 15.08.2024.
//

import Lottie
import SwiftUI

struct KikiLoadingView: View {
    var body: some View {
        LottieView(animation: .named("kiki"))
            .looping()
            .frame(height: 200)
            .scaleEffect(x: -1, y: 1)
    }
}

#Preview {
    KikiLoadingView()
}
