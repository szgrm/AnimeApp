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
    @State private var text: String = ""
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
                                Spacer()
                                ProgressView()
                                Text("Loading...")
                                Spacer()
                            }
                            .listRowBackground(Color.clear)
                            .task {
                                vm.loadMore()
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Animes")
                    .navigationBarTitleDisplayMode(.inline)
                    .scrollContentBackground(.hidden)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Image("Icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 65)
                                .padding(.leading, 110)
                                .padding(.bottom, 6)
                        }
                    }
                    .searchable(text: $text)
                    .toolbarBackground(.visible)
                    .refreshable {
                        vm.refresh()
                    }
                }
            }
        }
    }
}

#Preview {
    AnimeListView()
}
