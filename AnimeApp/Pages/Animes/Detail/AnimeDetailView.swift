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
                bannerSection

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
                                HStack(spacing: 10) {
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

                    trailerSection
                }
                .frame(width: screenWidth)
                .offset(y: -100)
            }
        }
        .task {
            vm.getAnimeDetail()
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
                            BannerImageView(url: bannerUrl, height: 260)
                                .scaledToFill()
                                .offset(y: isScrolled ? -offsetY : 0)

                        } else {
                            ProgressView()
                                .frame(width: screenWidth, height: 260)
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
            .frame(width: 230)
            .padding(.bottom, 5)
        }
        .frame(width: screenWidth - 30)
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
    
    private var trailerSection: some View {
        VStack(alignment: .leading) {
            
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
