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
    let character: CharacterSmall
    let screenWidth = UIScreen.main.bounds.size.width
    @State var isViewed: Bool = false

    init(character: CharacterSmall) {
        self.character = character
        vm = CharacterDetailViewModel(characterID: character.id, characterService: CharacterService())
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("AppColor"), Color("Background"), Color("Background"), Color("Background")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

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
        .task {
            await vm.getCharacterDetail()
        }
    }

    private var titleSection: some View {
        HStack(alignment: .bottom) {
            ImageView(
                url: (character.image?.large)!,
                width: 160,
                height: 220,
                cornerRadius: 10
            )
            VStack {
                Text(vm.characterDetail?.name?.full ?? "")
                    .font(Font.custom("OpenSans", size: 28))
                    .bold()
                    .multilineTextAlignment(.center)
                Text(vm.alternativeNamesFormatted ?? "")
                    .font(Font.custom("OpenSans", size: 11))
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
                        .padding(.horizontal, 30)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    CharacterInfoCellView(cellTitle: "GENDER", cellVariable: vm.characterDetail?.gender ?? "-")
                        .padding(.horizontal, 30)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    CharacterInfoCellView(cellTitle: "BIRTHDAY", cellVariable: DateUtil.formatDate(date: vm.characterDetail?.dateOfBirth))
                        .padding(.horizontal, 30)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    CharacterInfoCellView(cellTitle: "BLOOD TYPE", cellVariable: vm.characterDetail?.bloodType ?? "-")
                        .padding(.horizontal, 30)
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
                .foregroundStyle(.secondary)
                .font(Font.custom("OpenSans", size: 14))

            Text(.init(vm.characterDetail?.description ?? ""))
                .frame(maxWidth: screenWidth, alignment: .leading)
                .font(Font.custom("OpenSans", size: 14))
                .lineLimit(isViewed ? 60 : 5)
            Button(isViewed ? "Read Less" : "Read More") {
                withAnimation {
                    isViewed.toggle()
                }
            }
            .font(Font.custom("OpenSans", size: 14))
            .fontWeight(.semibold)
        }
        .padding(.horizontal, 15)
    }

    @ViewBuilder
    private var mediaSection: some View {
        if let animes = vm.characterDetail?.media?.nodes?.compactMap({ $0?.fragments.animeSmall }) {
            VStack(alignment: .leading, spacing: 10) {
                Text("MEDIA")
                    .frame(width: screenWidth - 30, alignment: .leading)
                    .foregroundStyle(.secondary)
                    .font(Font.custom("OpenSans", size: 14))

                ScrollView {
                    ForEach(animes) { anime in
                        if !(anime.isAdult ?? true) {
                            NavigationLink(destination: AnimeDetailView(anime: anime), label: {
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
