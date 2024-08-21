//
//  AnimeDetailContentView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 21.08.2024.
//

import SwiftUI

struct AnimeDetailContentView: View {
    let animeDetail: AnimeDetail
    let screenWidth = UIScreen.main.bounds.size.width
    @State var isViewed: Bool = false
    @State private var showDetail = false

    var body: some View {
        ScrollView {
            bannerSection

            VStack(spacing: 15) {
                titleSection

                infoCellSection

                summarySection

                characterSection

                trailerSection
            }
            .frame(width: screenWidth)
            .offset(y: -100)
        }
        .sheet(isPresented: $showDetail) {
            CoverImageView(coverImageUrl: animeDetail.coverImage.extraLarge)
        }
    }

    private var bannerSection: some View {
        GeometryReader { geometry in
            let offsetY = geometry.frame(in: .global).minY
            let isScrolled = offsetY > 0

            ZStack {
                if let bannerUrl = animeDetail.bannerImage {
                    BannerImageView(url: bannerUrl,
                                    height: isScrolled ? 250 + offsetY : 250,
                                    hex: animeDetail.coverImage.color ?? "#A176AD")
                        .offset(y: isScrolled ? -offsetY : 0)
                } else {
                    Rectangle()
                        .foregroundStyle(Color(hex: animeDetail.coverImage.color ?? "#A176AD"))
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

    private var titleSection: some View {
        HStack(alignment: .bottom) {
            Button(action: { showDetail.toggle() }, label: {
                ImageView(
                    url: animeDetail.coverImage.extraLarge,
                    width: 160,
                    height: 220,
                    cornerRadius: 10
                )
            })

            VStack {
                Text(((animeDetail.title.english) ?? (animeDetail.title.romaji)) ?? "")
                    .customFont(.bold, 28)
                    .multilineTextAlignment(.center)
                Text(animeDetail.title.native ?? "")
                    .customFont(.regular, 20)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(animeDetail.genres, id: \.self) { genre in
                            Text(genre!)
                                .customFont(.regular, 10)
                                .padding(3)
                                .background(Color("AppColor").opacity(0.4))
                                .clipShape(.capsule)
                        }
                    }
                }
                .padding(.leading, 15)
                .scrollIndicators(.hidden)
                .contentMargins(.leading, 15, for: .scrollContent)
            }
            .frame(width: screenWidth - 195)
            .padding(.bottom, 10)
        }
        .frame(width: screenWidth)
        .padding(.horizontal, 15)
    }

    private var infoCellSection: some View {
        VStack {
            Divider()
                .overlay(.secondary)
            ScrollView(.horizontal) {
                HStack {
                    AnimeInfoCellView(cellTitle: "SEASON YEAR", cellVariable: animeDetail.seasonYear)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    AnimeInfoCellView(cellTitle: "FORMAT", cellVariable: animeDetail.format.rawValue)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    AnimeInfoCellView(cellTitle: "EPISODES", cellVariable: animeDetail.episodes)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    AnimeInfoCellView(cellTitle: "STATUS", cellVariable: animeDetail.status.rawValue)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    AnimeInfoCellView(cellTitle: "SCORE", cellVariable: animeDetail.averageScore)
                }
            }
            .scrollIndicators(.hidden)
            Divider()
                .overlay(.secondary)
        }
        .padding(.horizontal, 15)
    }

    private var summarySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SUMMARY")
                .customFont(.regular, 16)
                .foregroundStyle(.secondary)

            TextUtility.cleanDescription(animeDetail.description)
                .customFont(.regular, 14)
                .frame(maxWidth: screenWidth, alignment: .leading)
                .lineLimit(isViewed ? 50 : 5)

            Button(action: {
                withAnimation {
                    isViewed.toggle()
                }
            }, label: {
                Text(isViewed ? "Show Less" : "Show More")
                    .customFont(.semiBold, 14)
            })
        }
        .padding(.horizontal, 15)
    }

    @ViewBuilder
    private var characterSection: some View {
        if let characters = animeDetail.characters {
            VStack(alignment: .leading, spacing: 10) {
                Text("CHARACTERS")
                    .customFont(.regular, 16)
                    .frame(alignment: .leading)
                    .foregroundStyle(.secondary)
                    .padding(.leading, 15)

                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(characters) { character in
                            NavigationLink(destination: CharacterDetailView(characterID: character.id), label: {
                                CharacterGridView(character: character)
                            })
                        }
                    }
                }
                .foregroundStyle(.primary)
                .contentMargins(.leading, 15, for: .scrollContent)
            }
        } else {
            ProgressView()
                .foregroundStyle(.secondary)
                .frame(width: screenWidth, height: 200)
        }
    }

    private var trailerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let ytID = animeDetail.trailer?.id {
                Text("TRAILER")
                    .customFont(.regular, 16)
                    .frame(width: screenWidth - 30, alignment: .leading)
                    .foregroundStyle(.secondary)
                YoutubeVideoView(ID: ytID)
                    .frame(width: screenWidth - 30, height: 250)
                    .cornerRadius(10)
            }
        }
    }
}
