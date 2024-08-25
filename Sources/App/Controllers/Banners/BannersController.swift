//
//  BannersController.swift
//
//
//  Created by Artem Mayer on 29.07.2024.
//

import Vapor
import Fluent

struct BannersController: RouteCollection {

    let bannersRepository: BannersRepositoryProtocol

    @Sendable func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api", "v1", "main_page")
        api.get("", use: get)
    }

    @Sendable private func get(_ request: Request) async throws -> [MainBannerDTO] {
        try await bannersRepository.get()
    }

}
