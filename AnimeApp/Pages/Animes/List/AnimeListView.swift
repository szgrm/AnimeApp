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
                ScrollViewReader { proxy in
                    ZStack(alignment: .bottomTrailing) {
                        ScrollView {
                            LazyVStack {
                                ForEach(vm.animes ?? []) { anime in
                                    NavigationLink(destination: AnimeDetailView(anime: anime), label: {
                                        AnimeListRowView(anime: anime)
                                    })
                                    .id(anime.id)
                                }
                                if vm.hasNextPage {
                                    HStack {
                                        ProgressView()
                                        Text("Loading...")
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                    }
                                    .padding(.leading, 15)
                                    .task {
                                        vm.loadMore()
                                    }
                                }
                            }
                            .padding(15)
                        }

                        .foregroundStyle(.primary)

                        Button {
                            withAnimation {
                                proxy.scrollTo(vm.animes?.first?.id)
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
                    .padding(.bottom, 10)
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
