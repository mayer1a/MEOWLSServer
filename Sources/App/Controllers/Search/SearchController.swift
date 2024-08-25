//
//  SearchController.swift
//
//
//  Created by Artem Mayer on 05.08.2024.
//

import Vapor
import Fluent

struct SearchController: RouteCollection {

    private let searchQuery = "query"

    let searchRepository: SearchRepositoryProtocol

    @Sendable func boot(routes: RoutesBuilder) throws {
        let search = routes.grouped("api", "v1", "search")

        search.get("popular_searches", use: getPopular)
        search.get("suggestions", use: getSuggestions)
    }

    @Sendable func getPopular(_ request: Request) async throws -> [SearchSuggestionDTO] {
        try await searchRepository.getPopular()
    }

    @Sendable func getSuggestions(_ request: Request) async throws -> [SearchSuggestionDTO] {
        guard let query: String = request.query[searchQuery] else {
            throw ErrorFactory.badRequest(.requestQueryParameterRequired)
        }
        
        return try await searchRepository.getSuggestions(for: query)
    }

}
