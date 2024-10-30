//
//  NetworkInterceptorProvider.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 17.07.2024.
//

import Apollo
import ApolloAPI
import Foundation

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors(for operation: some GraphQLOperation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(RequestLoggingInterceptor(), at: 0)
        interceptors.insert(AuthorizationInterceptor(), at: 1)
        interceptors.insert(ResponseLoggingInterceptor(), at: interceptors.count)
        return interceptors
    }
}
