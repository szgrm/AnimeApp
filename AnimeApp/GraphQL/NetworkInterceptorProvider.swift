//
//  NetworkInterceptorProvider.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 17.07.2024.
//

import Foundation
import Apollo
import ApolloAPI

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(RequestLoggingInterceptor(), at: 0)
        interceptors.insert(ResponseLoggingInterceptor(), at: interceptors.count)
        return interceptors
    }
}
