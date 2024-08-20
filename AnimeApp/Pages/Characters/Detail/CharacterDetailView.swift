//
//  CharacterDetailView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 31.07.2024.
//

import AnilistAPI
import NukeUI
import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var vm: CharacterDetailViewModel
    let characterID: Int
    let screenWidth = UIScreen.main.bounds.size.width
    @State var isViewed: Bool = false

    init(characterID: Int) {
        self.characterID = characterID
        vm = CharacterDetailViewModel(characterID: characterID, characterService: CharacterService())
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("AppColor"), Color("Background"), Color("Background"), Color("Background")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            switch vm.loadingState {
            case .loading:
                KikiLoadingView(height: 100, size: 16)
                    .task { await vm.getCharacterDetail() }
            case .loaded:
                content
            case .error:
                Text("Error")
                    .foregroundStyle(.secondary)
            case .noResult:
                NoResultView()
            }
        }
    }

    private var content: some View {
        ScrollView {
            VStack(spacing: 15) {
                titleSection

                infoCellSection

                descriptionSection

                mediaSection
            }
            .frame(width: screenWidth)
            .padding(.top, 50)
        }
    }

    private var titleSection: some View {
        HStack(alignment: .bottom) {
            ImageView(
                url: (vm.characterDetail?.image?.large)!,
                width: 160,
                height: 220,
                cornerRadius: 10
            )
            VStack {
                Text(vm.characterDetail?.name?.full ?? "")
                    .customFont(.bold, 28)
                    .multilineTextAlignment(.center)
                Text(vm.alternativeNamesFormatted ?? "")
                    .customFont(.regular, 12)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
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
                    CharacterInfoCellView(cellTitle: "AGE", cellVariable: vm.characterDetail?.age ?? "-")
                        .padding(.trailing, 10)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    CharacterInfoCellView(cellTitle: "GENDER", cellVariable: vm.characterDetail?.gender ?? "-")
                        .padding(.horizontal, 10)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    CharacterInfoCellView(cellTitle: "BIRTHDAY", cellVariable: DateUtil.formatDate(date: vm.characterDetail?.dateOfBirth))
                        .padding(.horizontal, 10)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    CharacterInfoCellView(cellTitle: "BLOOD TYPE", cellVariable: vm.characterDetail?.bloodType ?? "-")
                        .padding(.horizontal, 10)
                }
            }
            .scrollIndicators(.hidden)
            Divider()
                .overlay(.secondary)
        }
        .padding(.horizontal, 15)
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("DESCRIPTION")
                .customFont(.regular, 16)
                .foregroundStyle(.secondary)

            Text(.init(vm.characterDetail?.description ?? ""))
                .customFont(.regular, 14)
                .frame(maxWidth: screenWidth, alignment: .leading)
                .lineLimit(isViewed ? 60 : 5)
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
    private var mediaSection: some View {
        if let animes = vm.characterDetail?.media?.nodes?.compactMap({ $0?.fragments.animeSmall }) {
            VStack(alignment: .leading, spacing: 10) {
                Text("MEDIA")
                    .customFont(.regular, 16)
                    .frame(width: screenWidth - 30, alignment: .leading)
                    .foregroundStyle(.secondary)

                ScrollView {
                    ForEach(animes) { anime in
                        if !(anime.isAdult ?? true) {
                            NavigationLink(destination: AnimeDetailView(animeID: anime.id), label: {
                                CharacterAnimesRow(anime: anime)
                            })
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
            .padding(.horizontal, 15)

        } else {
            ProgressView()
                .foregroundStyle(.secondary)
                .frame(width: screenWidth, height: 200)
        }
    }
}

#Preview {
    CharacterDetailView(characterID: 1)
}
