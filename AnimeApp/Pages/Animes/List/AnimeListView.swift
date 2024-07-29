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
            List {
                ForEach(vm.animes ?? []) { anime in
                    NavigationLink(destination: AnimeDetailView(anime: anime), label: {
                        AnimeListRowView(anime: anime)
                    })
                    .padding(5)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
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
                    .task {
                        vm.loadMore()
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .navigationTitle("Animes")
            .toolbarBackground(.visible)
            .refreshable {
                vm.refresh()
            }
        }
    }
}

#Preview {
    AnimeListView()
}
