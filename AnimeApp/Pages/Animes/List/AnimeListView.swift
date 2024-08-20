//
//  AnimeListView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import AnilistAPI
import SwiftUI

struct AnimeListView: View {
    @StateObject private var vm = AnimeListViewModel(animeService: AnimeService())

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(edges: .all)

                switch vm.loadingState {
                case .loading:
                    KikiLoadingView(height: 100, size: 16)
                case .loaded: content
                case .error:
                    Text("Error")
                        .foregroundStyle(.secondary)
                case .noResult:
                    NoResultView()
                }
            }
            .refreshable {
                await vm.refresh()
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
                        Text("Animes")
                            .customFont(.semiBold, 18)
                    }
                    .padding(.bottom, 10)
                }
            }
            .searchable(text: $vm.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Anime")
            .toolbarBackground(.visible)
        }
    }

    private var content: some View {
        ScrollViewReader { proxy in
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.animes ?? []) { anime in
                            NavigationLink(destination: AnimeDetailView(animeID: anime.id), label: {
                                AnimeListRowView(anime: anime)
                            })
                            .id(anime.id)
                        }
                        if vm.hasNextPage {
                            LoadMoreView(loader: vm.loadMore)
                        }
                    }
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
}

#Preview {
    AnimeListView()
}
