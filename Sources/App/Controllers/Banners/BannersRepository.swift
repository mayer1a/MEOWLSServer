//
//  BannersRepository.swift
//
//
//  Created by Artem Mayer on 29.07.2024.
//

import Vapor
import Fluent

protocol BannersRepositoryProtocol: Sendable {

    func get() async throws -> [MainBannerDTO]

}

final class BannersRepository: BannersRepositoryProtocol {

    private let database: Database
    private let cache: Application.Caches

    init(database: Database, cache: Application.Caches) {
        self.database = database
        self.cache = cache
    }

    func get() async throws -> [MainBannerDTO] {

        if var banners = try await getFromCache() {

            let bannersIDs = banners.compactMap({ $0.products == nil ? nil : $0.id })

            let dbBanners = try await MainBanner.query(on: database)
                .filter(\.$id ~~ bannersIDs)
                .with(\.$products, { product in
                    product
                        .with(\.$images)
                        .with(\.$variants) { variant in
                            variant
                                .with(\.$price)
                                .with(\.$availabilityInfo)
                                .with(\.$badges)
                        }
                })
                .all()


            try await dbBanners.asyncForEach { banner in
                if let index = banners.firstIndex(where: { $0.id == banner.id }) {
                    banners[index].products = try await DTOBuilder.makeProducts(from: banner.products)
                }
            }

            return banners
        }

        let banners = try await eagerLoadRelations()
        let bannersDTO = try await DTOBuilder.makeBanners(from: banners)
        try await setCache(bannersDTO)

        return bannersDTO
    }

    private func eagerLoadRelations() async throws -> [MainBanner] {

        try await MainBanner.query(on: database)
            .filter(\.$parent.$id == nil)
            .with(\.$redirect)
            .with(\.$categories)
            .with(\.$uiSettings, { uiSettings in
                uiSettings
                    .with(\.$spasings)
                    .with(\.$cornerRadiuses)
                    .with(\.$metrics)
            })
            .with(\.$banners, { banner in
                banner
                    .with(\.$image)
                    .with(\.$redirect) { redirect in
                        redirect
                            .with(\.$sale)
                            .with(\.$productsSet) { $0.with(\.$category) }
                    }
            })
            .with(\.$products, { product in
                product
                    .with(\.$images)
                    .with(\.$variants) { variant in
                        variant
                            .with(\.$price)
                            .with(\.$availabilityInfo)
                            .with(\.$badges)
                    }
            })
            .with(\.$image)
            .all()
    }

    private func setCache(_ response: [MainBannerDTO]) async throws {

        do {
            try await cache.memory.set("banners", to: response, expiresIn: .seconds(Date().secondsUntilEndOfDay))
        } catch {
            try await cache.memory.delete("banners")
        }
    }

    private func getFromCache() async throws -> [MainBannerDTO]? {
        
        try await cache.memory.get("banners", as: [MainBannerDTO].self)
    }

}

