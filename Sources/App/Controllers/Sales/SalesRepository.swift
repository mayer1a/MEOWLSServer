//
//  SalesRepository.swift
//  
//
//  Created by Artem Mayer on 05.08.2024.
//

import Vapor
import Fluent

protocol SalesRepositoryProtocol: Sendable {

    func get(for saleType: SaleType, with page: PageRequest) async throws -> PaginationResponse<SaleDTO>
    func get(for saleID: UUID) async throws -> SaleDTO

}

final class SalesRepository: SalesRepositoryProtocol {

    private let database: Database
    private let cache: Application.Caches

    init(database: Database, cache: Application.Caches) {
        self.database = database
        self.cache = cache
    }

    func get(for saleType: SaleType, with page: PageRequest) async throws -> PaginationResponse<SaleDTO> {

        if let sales = try await getFromCache(for: saleType, page) { return sales }

        let paginationSales = try await eagerLoadRelations(for: saleType, page)
        let salesDTO = try DTOFactory.makeSales(from: paginationSales.results)
        let paginationSalesDTOs = PaginationResponse(results: salesDTO, paginationInfo: paginationSales.paginationInfo)

        try await setCache(paginationSalesDTOs, for: saleType, page)

        return paginationSalesDTOs
    }

    func get(for saleID: UUID) async throws -> SaleDTO {

        guard let sale = try await eagerLoadSale(for: nil, saleID: saleID).first() else {
            throw ErrorFactory.badRequest(.saleNotFound)
        }
        return try DTOFactory.makeSale(from: sale, fullModel: true)
    }

    private func eagerLoadRelations(for type: SaleType, _ page: PageRequest) async throws -> PaginationResponse<Sale> {
        try await eagerLoadSale(for: type, saleID: nil)
            .paginate(with: page)
    }

    private func eagerLoadSale(for type: SaleType?, saleID: UUID?) async throws -> QueryBuilder<Sale> {
        var saleBuilder = Sale.query(on: database)

        if let type {
            saleBuilder = saleBuilder
                .filter(\.$saleType == type)
                .filter(\.$saleType == type)
                .filter(\.$endDate >= Date.now)
        } else if let saleID {
            saleBuilder = saleBuilder
                .filter(\.$id == saleID)
                .with(\.$products) { product in
                    product
                        .with(\.$images)
                        .with(\.$variants) { variant in
                            variant
                                .with(\.$badges)
                                .with(\.$price)
                                .with(\.$availabilityInfo)
                        }
                }
        } else {
            fatalError("type or saleID should be NOT nil")
        }

        return saleBuilder
            .with(\.$image)
    }

    private func setCache(_ response: PaginationResponse<SaleDTO>,
                          for type: SaleType,
                          _ page: PageRequest) async throws {

        let cacheName = "\(type)Sales_\(page.page)Page"
        do {
            let expiresIn = CacheExpirationTime.seconds(Date().secondsUntilEndOfDay)
            try await cache.memory.set(cacheName, to: response, expiresIn: expiresIn)
        } catch {
            try await cache.memory.delete(cacheName)
        }
    }

    private func getFromCache(for type: SaleType, _ page: PageRequest) async throws -> PaginationResponse<SaleDTO>? {

        let cacheName = "\(type)Sales_\(page.page)Page"
        return try await cache.memory.get(cacheName, as: PaginationResponse<SaleDTO>.self)
    }

}
