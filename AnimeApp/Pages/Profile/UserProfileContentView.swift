//
//  UserProfileContentView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 29.10.2024.
//

import SwiftUI

struct UserProfileContentView: View {
    let userInfo: UserInfo

    var body: some View {
        ScrollView {
            bannerSection

            VStack(spacing: 15) {
                avatarSection
            }
        }
    }

    private var bannerSection: some View {
        GeometryReader { geometry in
            let offsetY = geometry.frame(in: .global).minY
            let isScrolled = offsetY > 0

            ZStack {
                if let bannerUrl = userInfo.bannerImage {
                    BannerImageView(
                        url: bannerUrl,
                        height: isScrolled ? 250 + offsetY : 250,
                        hex: "#A176AD"
                    )
                    .offset(y: isScrolled ? -offsetY : 0)
                    .accessibilityIdentifier("BannerImageView")

                } else {
                    Rectangle()
                        .foregroundStyle(Color(hex: "#A176AD"))
                        .frame(width: geometry.size.width, height: isScrolled ? 250 + offsetY : 250)
                        .offset(y: isScrolled ? -offsetY : 0)
                }

                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.clear, Color("Background")]), startPoint: .top, endPoint: .bottom))
            }
        }
        .frame(height: 250)
    }

    private var avatarSection: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom) {
                ImageView(
                    url: userInfo.avatar,
                    width: 150,
                    height: 150,
                    cornerRadius: 10
                )
                Text(userInfo.name)
                    .customFont(.bold, 28)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
            }
            .frame(width: geometry.size.width - 10)
        }
    }
}
