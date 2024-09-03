//
//  CharacterListView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 31.07.2024.
//

import AnilistAPI
import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel(characterService: CharacterService())
    @State private var searchTerm = ""

    let screenWidth = UIScreen.main.bounds.size.width

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(edges: .all)

                switch viewModel.viewState {
                case .loading:
                    KikiLoadingView(height: 100, size: 16)
                case let .loaded(characters):
                    content(characters: characters)
                case let .error(error):
                    ErrorView(error: error)
                case .noResult:
                    NoResultView()
                }
            }
            .refreshable {
                await viewModel.refresh()
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
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Character")
            .onChange(of: searchTerm) {
                viewModel.searchTerm = searchTerm
            }
            .toolbarBackground(.visible)
        }
    }

    private func content(characters: [Characters]) -> some View {
        ScrollViewReader { proxy in
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVGrid(columns: [
                        .init(.flexible()),
                        .init(.flexible()),
                        .init(.flexible())
                    ], spacing: 20) {
                        ForEach(characters) { character in
                            NavigationLink(destination: CharacterDetailView(characterID: character.id), label: {
                                CharactersListCellView(character: character)
                            })
                            .id(character.id)
                        }
                        if viewModel.hasNextPage {
                            LoadMoreView(loader: viewModel.loadMore)
                        }
                    }
                }
                .padding(.horizontal, 15)
                .foregroundStyle(.primary)

                Button {
                    withAnimation {
                        proxy.scrollTo(characters.first?.id)
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
    CharacterListView()
}
