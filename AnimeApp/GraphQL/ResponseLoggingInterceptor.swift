//
//  ResponseLoggingInterceptor.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 17.07.2024.
//

import Apollo
import ApolloAPI
import Foundation
import OSLog

class ResponseLoggingInterceptor: ApolloInterceptor {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: ResponseLoggingInterceptor.self)
    )

    enum ResponseLoggingError: Error {
        case notYetReceived
    }

    public var id: String = UUID().uuidString

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        defer {
            chain.proceedAsync(
                request: request,
                response: response,
                interceptor: self,
                completion: completion
            )
        }

        guard let receivedResponse = response else {
            chain.handleErrorAsync(
                ResponseLoggingError.notYetReceived,
                request: request,
                response: response,
                completion: completion
            )
            return
        }

        logger.debug("HTTP Response: \(receivedResponse.httpResponse)")

        if let stringData = String(bytes: receivedResponse.rawData, encoding: .utf8) {
            logger.debug("Data: \(stringData)")
        } else {
            logger.debug("Could not convert data to string!")
        }
    }
}
