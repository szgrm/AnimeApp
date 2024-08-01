//
//  AnimeListView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import AnilistAPI
import SwiftUI

struct AnimeListView: View {
    @StateObject private var vm = AnimeListViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(edges: .all)
                VStack {
                    List {
                        ForEach(vm.animes ?? []) { anime in
                            NavigationLink(destination: AnimeDetailView(anime: anime), label: {
                                AnimeListRowView(anime: anime)
                            })

                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                        if vm.hasNextPage {
                            HStack {
                                ProgressView()
                                Text("Loading...")
                                    .foregroundStyle(.secondary)
                                Spacer()
                            }
                            .padding(.leading, 10)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .task {
                                vm.loadMore()
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .refreshable {
                vm.refresh()
            }
            .navigationTitle("Animes")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image("Icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 65)
                        Text("Animes").font(.headline)
                    }
                }
            }
            .searchable(text: $vm.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Anime")
            .toolbarBackground(.visible)
        }
    }
}

#Preview {
    AnimeListView()
}
