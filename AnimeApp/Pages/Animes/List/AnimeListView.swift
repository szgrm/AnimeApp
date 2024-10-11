//
//  AnimeListView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import AnilistAPI
import SwiftUI

struct AnimeListView: View {
    @StateObject private var viewModel = AnimeListViewModel(animeService: AnimeService())
    @State private var searchTerm = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(edges: .all)

                switch viewModel.viewState {
                case .initial:
                    KikiLoadingView(height: 100, size: 16)
                        .task { await viewModel.getAnimes() }
                case .loading:
                    KikiLoadingView(height: 100, size: 16)
                case let .loaded(animes):
                    content(animes: animes)
                case let .error(error):
                    ErrorView(error: error)
                case .noResult:
                    NoResultView()
                }
            }
            .refreshable {
                await viewModel.refresh()
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
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Anime")
            .onChange(of: searchTerm) {
                viewModel.searchTerm = searchTerm
            }
            .toolbarBackground(.visible)
        }
    }

    private func content(animes: [Anime]) -> some View {
        ScrollViewReader { proxy in
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack {
                        ForEach(animes) { anime in
                            NavigationLink(destination: AnimeDetailView(animeID: anime.id), label: {
                                AnimeListRowView(anime: anime)
                            })
                            .id(anime.id)
                        }
                        if viewModel.hasNextPage {
                            LoadMoreView(loader: viewModel.loadMore)
                        }
                    }
                }
                .foregroundStyle(.primary)

                Button {
                    withAnimation {
                        proxy.scrollTo(animes.first?.id)
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
