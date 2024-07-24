//
//  RequestLoggingInterceptor.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 17.07.2024.
//

import Apollo
import ApolloAPI
import Foundation
import OSLog

class RequestLoggingInterceptor: ApolloInterceptor {
    public var id: String = UUID().uuidString
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: RequestLoggingInterceptor.self)
    )

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        logger.debug("Request: \(request.debugDescription)")
        chain.proceedAsync(
            request: request,
            response: response,
            interceptor: self,
            completion: completion
        )
    }
}
