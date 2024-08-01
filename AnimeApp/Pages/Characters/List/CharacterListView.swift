//
//  CharacterListView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 31.07.2024.
//

import AnilistAPI
import SwiftUI

struct CharacterListView: View {
    @StateObject private var vm = CharacterListViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(edges: .all)

                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [
                        .init(
                            .adaptive(minimum: 85),
                            spacing: 20
                        ),
                    ], spacing: 20) {
                        ForEach(vm.characters ?? []) { character in
                            NavigationLink(destination: CharacterDetailView(character: character), label: {
                                CharactersListCellView(character: character)
                            })
                        }
                        if vm.hasNextPage {
                            HStack {
                                ProgressView()
                                Text("Loading...")
                                    .foregroundStyle(.secondary)
                                Spacer()
                            }
                            .padding(.leading, 10)
                            .task {
                                vm.loadMore()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .foregroundStyle(.primary)
            }
            .refreshable {
                vm.refresh()
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
                        Text("Characters").font(.headline)
                    }
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
