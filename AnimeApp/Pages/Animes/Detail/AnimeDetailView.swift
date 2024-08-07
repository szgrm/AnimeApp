//
//  AnimeDetailView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import AnilistAPI
import NukeUI
import SwiftUI

struct AnimeDetailView: View {
    let anime: AnimeSmall
    @ObservedObject var vm: AnimeDetailViewModel
    @State var isViewed: Bool = false
    let screenWidth = UIScreen.main.bounds.size.width

    init(anime: AnimeSmall) {
        self.anime = anime
        vm = AnimeDetailViewModel(animeID: anime.id, animeService: AnimeService())
    }

    var body: some View {
        ZStack {
            Color("Background")

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
        }
        .task {
            await vm.getAnimeDetail()
        }
        .ignoresSafeArea()
    }

    private var bannerSection: some View {
        GeometryReader { geometry in
            let offsetY = geometry.frame(in: .global).minY
            let isScrolled = offsetY > 0

            Spacer()
                .frame(height: isScrolled ? 250 + offsetY : 250)
                .background {
                    ZStack {
                        if let bannerUrl = vm.animeDetail?.bannerImage {
                            BannerImageView(url: bannerUrl,
                                            height: 260,
                                            hex: anime.coverImage?.color ?? "#A176AD")
                                .scaledToFill()
                                .offset(y: isScrolled ? -offsetY : 0)

                        } else {
                            Rectangle()
                                .scaledToFill()
                                .offset(y: isScrolled ? -offsetY : 0)
                                .foregroundStyle(Color(hex: anime.coverImage?.color ?? "#A176AD"))
                                .frame(width: screenWidth)
                        }

                        Rectangle()
                            .foregroundColor(.clear)
                            .background(LinearGradient(gradient: Gradient(colors: [.clear, Color("Background")]), startPoint: .top, endPoint: .bottom))
                    }
                }
        }
        .frame(height: 260)
    }

    private var titleSection: some View {
        HStack(alignment: .bottom) {
            NavigationLink(destination: CoverImageView(coverImageUrl: (vm.animeDetail?.coverImage?.extraLarge ?? anime.coverImage?.large)!),
                           label: {
                               ImageView(
                                   url: (anime.coverImage?.large)!,
                                   width: 160,
                                   height: 220,
                                   cornerRadius: 10
                               )
                           })

            VStack {
                Text(((anime.title?.english) ?? (anime.title?.romaji)) ?? "")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                Text(vm.animeDetail?.title?.native ?? "")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(vm.animeDetail?.genres ?? [], id: \.self) { genre in
                            Text(genre!)
                                .font(.system(size: 10))
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
                    AnimeInfoCellView(cellTitle: "SEASON YEAR", cellVariable: "\(String(vm.animeDetail?.seasonYear ?? 0))")
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    AnimeInfoCellView(cellTitle: "FORMAT", cellVariable: vm.animeDetail?.format?.rawValue ?? "-")
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    AnimeInfoCellView(cellTitle: "EPISODES", cellVariable: "\(String(vm.animeDetail?.episodes ?? 0))")
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    AnimeInfoCellView(cellTitle: "STATUS", cellVariable: vm.animeDetail?.status?.rawValue ?? "-")
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    AnimeInfoCellView(cellTitle: "SCORE", cellVariable: "\(String(describing: vm.animeDetail?.averageScore ?? 0))% ")
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
                .foregroundStyle(.secondary)
                .font(.system(size: 14))

            TextUtility.cleanDescription(anime.description ?? "")
                .frame(maxWidth: screenWidth, alignment: .leading)
                .font(.system(size: 14))
                .lineLimit(isViewed ? 50 : 5)
            Button(isViewed ? "Read Less" : "Read More") {
                withAnimation {
                    isViewed.toggle()
                }
            }
            .font(.system(size: 14, weight: .semibold))
        }
        .padding(.horizontal, 15)
    }

    @ViewBuilder
    private var characterSection: some View {
        if let characters = vm.animeDetail?.characters?.nodes?.compactMap({ $0?.fragments.characterSmall }) {
            VStack(alignment: .leading, spacing: 10) {
                Text("CHARACTERS")
                    .frame(alignment: .leading)
                    .foregroundStyle(.secondary)
                    .font(.system(size: 14))
                    .padding(.leading, 15)

                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(characters) { character in
                            NavigationLink(destination: CharacterDetailView(character: character), label: {
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
            if let ytID = vm.animeDetail?.trailer?.id {
                Text("TRAILER")
                    .frame(width: screenWidth - 30, alignment: .leading)
                    .foregroundStyle(.secondary)
                    .font(.system(size: 14))
                YoutubeVideoView(ID: ytID)
                    .frame(width: screenWidth - 30, height: 250)
                    .cornerRadius(10)
            }
        }
    }
}
