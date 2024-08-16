//
//  CharacterListView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 31.07.2024.
//

import AnilistAPI
import SwiftUI

struct CharacterListView: View {
    @StateObject private var vm = CharacterListViewModel(characterService: CharacterService())

    let screenWidth = UIScreen.main.bounds.size.width

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(edges: .all)
                ScrollViewReader { proxy in
                    ZStack(alignment: .bottomTrailing) {
                        ScrollView {
                            LazyVGrid(columns: [
                                .init(.flexible()),
                                .init(.flexible()),
                                .init(.flexible()),
                            ], spacing: 20) {
                                ForEach(vm.characters ?? []) { character in
                                    NavigationLink(destination: CharacterDetailView(character: character), label: {
                                        CharactersListCellView(character: character)
                                    })
                                    .id(character.id)
                                }
                                if vm.hasNextPage {
                                    LoadMoreView(loader: vm.loadMore)
                                }
                            }
                        }
                        .padding(.horizontal, 15)
                        .foregroundStyle(.primary)

                        Button {
                            withAnimation {
                                proxy.scrollTo(vm.characters?.first?.id)
                            }
                        } label: {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .tint(Color("AppColor").opacity(0.4))
                                .frame(width: 40)
                                .padding(15)
                        }
                    }
                }
            }
            .refreshable {
                await vm.refresh()
            }
            .navigationTitle("Characters")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image("Icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 65)
                        Text("Characters")
                            .customFont(.semiBold, 18)
                    }
                    .padding(.bottom, 10)
                }
            }
            .searchable(text: $vm.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Character")
            .toolbarBackground(.visible)
        }
    }
}

#Preview {
    CharacterListView()
}
