//
//  AnimeDetailView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import SwiftUI
import AnilistAPI
import NukeUI

struct AnimeDetailView: View {
    let anime: GetAnimesQuery.Data.Page.Medium
    @ObservedObject var vm: AnimeDetailViewModel
    var animeID: Int
    let columns = [
        GridItem(.adaptive(minimum: 75))
    ]
    
    init(anime: GetAnimesQuery.Data.Page.Medium ){
        self.anime = anime
        self.animeID = anime.id
        self.vm = AnimeDetailViewModel(animeID: animeID)
    }
    
    
    var body: some View {
        
        List {
            infoSection
            
            if let characters = vm.animeDetail?.characters?.nodes?.compactMap({$0}) {
                Section(header: Text("Characters")) {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(characters, id:\.id) { character in
                                CharacterGridView(character: character)
                            }
                        }
                        
                    }
                }
                .padding(5)
            }
        }
        .navigationTitle(anime.title?.english ?? "Anime Detail")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            vm.getAnimeDetail()
        }
    }
    private var infoSection: some View {
        Section {
            HStack {
                Spacer()
                VStack {
                    Text(vm.animeDetail?.title?.english ?? "")
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Text(vm.animeDetail?.title?.native ?? "")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    
                    AniImageView(
                        url: (anime.coverImage?.large)!,
                        width: 200,
                        height: 300,
                        cornerRadius: 15
                    )
                    
                    HStack {
                        ForEach(vm.animeDetail?.genres?.prefix(3) ?? [], id: \.self) { genre in
                            Text(genre!)
                                .font(.system(size: 10))
                                .padding(3)
                                .background(Color("AppColor").opacity(0.4))
                                .clipShape(.capsule)
                                
                        }
                    }
                    
                    Text(" Episodes \(vm.animeDetail?.episodes ?? 0)")
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                }
                Spacer()
                
            }
            .listRowSeparator(.hidden)

            TextUtility.cleanDescription(anime.description ?? "")
                .font(.system(size: 14))
                .padding(.vertical, 5)
        }
        
        .ignoresSafeArea()

    }
}

