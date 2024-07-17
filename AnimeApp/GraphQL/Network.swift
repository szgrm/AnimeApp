//
//  Network.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 12.07.2024.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    private(set) lazy var apollo: ApolloClient = {
        
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        
        let provider = NetworkInterceptorProvider(store: store)
        let url = URL(string: "https://graphql.anilist.co")!
        
        let requestChainTransport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: url
        )
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }()
}

