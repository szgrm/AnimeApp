//
//  CharacterDetailContentView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 21.08.2024.
//

import SwiftUI

struct CharacterDetailContentView: View {
    let characterDetail: CharacterDetail
    let screenWidth = UIScreen.main.bounds.size.width
    @State var isViewed: Bool = false
    var body: some View {
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
                url: characterDetail.image.large,
                width: 160,
                height: 220,
                cornerRadius: 10
            )
            VStack {
                Text(characterDetail.name.full ?? "")
                    .customFont(.bold, 28)
                    .multilineTextAlignment(.center)
                Text(characterDetail.alternativeNamesFormatted ?? "")
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
                    CharacterInfoCellView(cellTitle: "AGE", cellVariable: characterDetail.age)
                        .padding(.trailing, 10)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    CharacterInfoCellView(cellTitle: "GENDER", cellVariable: characterDetail.gender)
                        .padding(.horizontal, 10)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    CharacterInfoCellView(cellTitle: "BIRTHDAY", cellVariable: characterDetail.dateOfBirth.formatDate())
                        .padding(.horizontal, 10)
                    Divider()
                        .frame(height: 40)
                        .overlay(.secondary)

                    CharacterInfoCellView(cellTitle: "BLOOD TYPE", cellVariable: characterDetail.bloodType)
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

            Text(.init(characterDetail.description))
                .customFont(.regular, 14)
                .frame(maxWidth: screenWidth, alignment: .leading)
                .lineLimit(isViewed ? 60 : 5)
                .accessibilityIdentifier("descriptionText")
            Button(action: {
                withAnimation {
                    isViewed.toggle()
                }
            }, label: {
                Text(isViewed ? "Show Less" : "Show More")
                    .customFont(.semiBold, 14)
            })
            .accessibilityIdentifier("showMoreToggle")
        }
        .padding(.horizontal, 15)
    }

    @ViewBuilder
    private var mediaSection: some View {
        if let animes = characterDetail.media {
            VStack(alignment: .leading, spacing: 10) {
                Text("MEDIA")
                    .customFont(.regular, 16)
                    .frame(width: screenWidth - 30, alignment: .leading)
                    .foregroundStyle(.secondary)

                ScrollView {
                    ForEach(animes) { anime in
                        if !(anime.isAdult) {
                            NavigationLink(destination: AnimeDetailView(animeID: anime.id), label: {
                                CharacterAnimesRow(anime: anime)
                            })
                            .accessibilityIdentifier("animeCell")
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
