//
//  RegisterRoutes.swift
//
//
//  Created by Artem Mayer on 26.06.2024.
//

import Fluent
import Vapor

struct RegisterRoutes {

    static func register(for app: Application) throws {

        // For render.com
        app.get("health-check") { _ async throws in DummyResponse() }

        let tokenRepository = TokenRepository(database: app.db)
        let favoritesRepository = FavoritesRepository(database: app.db)
        let userRepository = UserRepository(database: app.db, with: favoritesRepository, tokenRepository)
        let bannersRepository = BannersRepository(database: app.db, cache: app.caches)
        let categoryRepository = CategoryRepository(database: app.db)
        let productsRepository = ProductsRepository(database: app.db)
        let salesRepository = SalesRepository(database: app.db, cache: app.caches)
        let searchRepository = SearchRepository(database: app.db, cache: app.caches)

        try app.register(collection: UserController(with: userRepository, tokenRepository))
        try app.register(collection: BannersController(bannersRepository: bannersRepository))
        try app.register(collection: FavoritesController(favoritesRepository: favoritesRepository))
        try app.register(collection: CategoryController(categoryRepository: categoryRepository))
        try app.register(collection: ProductsController(productsRepository: productsRepository))
        try app.register(collection: SalesController(salesRepository: salesRepository))
        try app.register(collection: SearchController(searchRepository: searchRepository))

        app.routes.print()
    }

    private init() {}

}
