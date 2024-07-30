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
    var animeID: Int
    @State var isViewed: Bool = false
    let screenWidth = UIScreen.main.bounds.size.width

    init(anime: AnimeSmall) {
        self.anime = anime
        animeID = anime.id
        vm = AnimeDetailViewModel(animeID: animeID)
    }

    var body: some View {
        ZStack {
            Color("Background")

            ScrollView {
                if let bannerUrl = vm.animeDetail?.bannerImage {
                    BannerImageView(url: bannerUrl, height: 250)
                        .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom))
                } else {
                    ProgressView()
                        .frame(width: screenWidth, height: 250)
                }

                VStack(spacing: 15) {
                    titleSection

                    infoCellSection

                    summarySection

                    if let characters = vm.animeDetail?.characters?.nodes?.compactMap({ $0?.fragments.characterSmall }) {
                        VStack(alignment: .leading) {
                            Text("CHARACTERS")
                                .frame(alignment: .leading)
                                .foregroundStyle(.secondary)
                                .font(.system(size: 14))
                                .padding(.leading, 15)

                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(characters) { character in
                                        CharacterGridView(character: character)
                                    }
                                }
                            }
                            .padding(.leading, 15)
                        }
                    } else {
                        ProgressView()
                            .frame(width: screenWidth, height: 200)
                    }

                    VStack(alignment: .leading) {
                        Text("TRAILER")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 14))

                        if let ytID = vm.animeDetail?.trailer?.id {
                            YoutubeVideoView(ID: ytID)
                        }
                    }
                    .frame(width: screenWidth - 15, alignment: .leading)
                    .padding(.leading, 15)
                }
                .frame(width: screenWidth)
                .offset(y: -120)
            }
        }
        .task {
            vm.getAnimeDetail()
        }
        .ignoresSafeArea()
    }

    private var titleSection: some View {
        HStack(alignment: .bottom) {
            AniImageView(
                url: (anime.coverImage?.large)!,
                width: 150,
                height: 0,
                cornerRadius: 10
            )

            VStack {
                Text(vm.animeDetail?.title?.english ?? "")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                Text(vm.animeDetail?.title?.native ?? "")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                HStack {
                    ForEach(vm.animeDetail?.genres?.prefix(3) ?? [], id: \.self) { genre in
                        Text(genre!)
                            .font(.system(size: 10))
                            .padding(3)
                            .background(Color("AppColor").opacity(0.4))
                            .clipShape(.capsule)
                    }
                }
            }
            .frame(width: 220)
            .padding(.bottom, 5)
        }
    }

    private var infoCellSection: some View {
        VStack {
            Divider()
                .overlay(.secondary)
            ScrollView(.horizontal) {
                HStack {
                    AnimeInfoCellView(cellTitle: "SEASON YEAR", cellVariable: "\(String(vm.animeDetail?.seasonYear ?? 0))")

                    AnimeInfoCellView(cellTitle: "FORMAT", cellVariable: vm.animeDetail?.format?.rawValue ?? "-")

                    AnimeInfoCellView(cellTitle: "EPISODES", cellVariable: "\(String(vm.animeDetail?.episodes ?? 0))")

                    AnimeInfoCellView(cellTitle: "STATUS", cellVariable: vm.animeDetail?.status?.rawValue ?? "-")

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
        VStack(alignment: .leading) {
            Text("SUMMARY")
                .foregroundStyle(.secondary)
                .font(.system(size: 14))
            TextUtility.cleanDescription(anime.description ?? "")
                .multilineTextAlignment(.leading)
                .font(.system(size: 14))
                .padding(.vertical, 3)
                .foregroundStyle(.primary)
                .lineLimit(isViewed ? 50 : 5)
            Button(isViewed ? "Read Less" : "Read More") {
                isViewed.toggle()
            }
            .font(.system(size: 14, weight: .semibold))
        }
        .padding(.horizontal, 15)
    }
}
