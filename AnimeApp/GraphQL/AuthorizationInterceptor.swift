//
//  AuthorizationInterceptor.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 29.10.2024.
//

import Apollo
import ApolloAPI
import Foundation
import KeychainSwift

class AuthorizationInterceptor: ApolloInterceptor {
    public var id: String = UUID().uuidString

    private let keychain = KeychainUtil.shared.keychain

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        if let token = keychain.get("accessToken") {
            request.addHeader(name: "Authorization", value: "Bearer \(token)")
        }

        chain.proceedAsync(
            request: request,
            response: response,
            interceptor: self,
            completion: completion
        )
    }
}
