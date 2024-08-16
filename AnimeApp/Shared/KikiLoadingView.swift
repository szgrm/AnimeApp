//
//  KikiLoadingView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 15.08.2024.
//

import Lottie
import SwiftUI

struct KikiLoadingView: View {
    let height: CGFloat
    let size: CGFloat
    var body: some View {
        VStack {
            LottieView(animation: .named("kiki"))
                .looping()
                .scaleEffect(x: -1, y: 1)
                .frame(height: height)
            Text("Loading...")
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .font(.custom("OpenSans", size: size))
        }
    }
}
