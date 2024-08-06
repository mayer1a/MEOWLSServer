//
//  SearchRepository.swift
//
//
//  Created by Artem Mayer on 05.08.2024.
//

import Vapor
import FluentPostgresDriver

protocol SearchRepositoryProtocol: Sendable {

    func getSuggestions(for query: String) async throws -> [SearchSuggestionDTO]
    func getPopular() async throws -> [SearchSuggestionDTO]

}

final class SearchRepository: SearchRepositoryProtocol {

    private let database: Database
    private let cache: Application.Caches
    private let suggestionsLimit = 20
    private let popularCacheKey = "popular"

    init(database: Database, cache: Application.Caches) {
        self.database = database
        self.cache = cache
    }

    func getSuggestions(for query: String) async throws -> [SearchSuggestionDTO] {

        if let cachedSuggestions = try await getFromCache(for: query) { return cachedSuggestions }

        guard let postgres = (database as? PostgresDatabase)?.sql() else { throw Abort(.internalServerError) }

        var limit = suggestionsLimit

        var categoriesRaw = try await getSQLForQuery(postgres, query: query, for: Category.self, limit: limit)
        limit -= categoriesRaw.result.count

        let productsRaw: SQLRawResponse<Product>
        if limit > 0 {

            productsRaw = try await getSQLForQuery(postgres, query: query, for: Product.self, limit: limit)
        } else {

            productsRaw = .init()
        }

        categoriesRaw.result = try await eagerLoad(for: categoriesRaw.result)

        let searchSuggestions = try await DTOBuilder.makeSearchSuggestions(from: categoriesRaw, productsRaw)
        try await setCache(searchSuggestions, for: query)

        return searchSuggestions
    }

    func getPopular() async throws -> [SearchSuggestionDTO] {

        if let cachedPopular = try await getFromCache(for: popularCacheKey) { return cachedPopular }

        // Get ~20 child shuffled categories IDs
        let categoriesIDs = try await Category.query(on: database)
            .filter(\.$code ~~ ["koshki", "sobaki"])
            .with(\.$childCategories, { child in
                child.with(\.$childCategories)
            })
            .all()
            .shuffled()
            .enumerated()
            .asyncMap({ index, parent in
                parent.childCategories.prefix(14 - (index * 2)).shuffled().prefix(3 - index)
            })
            .reduce(into: [UUID](), { partialResult, children in
                try children.forEach { middle in
                    try middle.childCategories.shuffled().prefix(4).forEach { child in
                        partialResult.append(try child.requireID())
                    }
                }
            })

        // Get products for each child category. [products.count == categories.count]
        var nextProductsPrefix = 1
        let products = try await Category.query(on: database)
            .filter(\.$id ~~ categoriesIDs)
            .with(\.$products)
            .all()
            .reduce(into: [Product]()) { partialResult, category in
                let product = category.products.shuffled().prefix(nextProductsPrefix)
                nextProductsPrefix = product.count == nextProductsPrefix ? 1 : nextProductsPrefix + 1
                partialResult.append(contentsOf: product)
            }

        let popularSuggestions = try await DTOBuilder.makeSearchSuggestions(from: .init(), .init(result: products))

        try await setCache(popularSuggestions, for: popularCacheKey, expiresIn: .seconds(Date().secondsUntilEndOfDay))

        return popularSuggestions
    }

    private func getSQLForQuery<T: Model>(_ postgres: any SQLDatabase,
                                          query: String,
                                          for type: T.Type,
                                          limit: Int) async throws -> SQLRawResponse<T> {

        guard type is Category.Type || type is Product.Type else { fatalError(SearchSQLRawQuery.Error.fatal) }

        let tableName = String(describing: type).pluralize()
        let select: SQLQueryString? = type is Category.Type ? "SELECT ID" : nil

        let rawSQL = SearchSQLRawQuery.get(query: query, tableName: tableName, limit: limit, selectPart: select)
        let result = postgres.raw("\(rawSQL)")

        let decodedResult = try await result.all(decodingFluent: type)
        let highlightedText = try await result.all(decodingColumn: SearchSQLRawQuery.tsQueryColumn, as: String.self)

        return SQLRawResponse(result: decodedResult, highlightedText: highlightedText)
    }

    private func eagerLoad(for categoriesIDs: [Category]) async throws -> [Category] {

        try await Category.query(on: database)
            .filter(\.$id ~~ categoriesIDs.map({try $0.requireID()}))
            .with(\.$parent, { parent in
                parent.with(\.$parent)
            })
            .all()
    }

    private func setCache(_ response: [SearchSuggestionDTO],
                          for query: String,
                          expiresIn: CacheExpirationTime = .minutes(5)) async throws {

        let cacheName = "\(query)_search"
        do {
            try await cache.memory.set(cacheName, to: response, expiresIn: expiresIn)
        } catch {
            try await cache.memory.delete(cacheName)
        }
    }

    private func getFromCache(for query: String) async throws -> [SearchSuggestionDTO]? {

        let cacheName = "\(query)_search"
        return try await cache.memory.get(cacheName, as: [SearchSuggestionDTO].self)
    }

}
