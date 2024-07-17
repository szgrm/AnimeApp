//
//  AnimeListView.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import SwiftUI
import AnilistAPI

struct AnimeListView: View {
    @StateObject private var vm = AnimeListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.animes ?? [], id: \.id) { anime in
                    NavigationLink(destination: AnimeDetailView(anime: anime), label: {
                        AnimeListRowView(anime: anime)
                    })
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
            .refreshable {
                vm.refresh()
            }
        }
    }
}

#Preview {
    AnimeListView()
}
