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

        // Health check
        app.get("") { _ async throws in HTTPResponseStatus.ok }
        app.get("health-check") { _ async throws in DummyResponse() }

        let tokenRepository = TokenRepository(database: app.db)
        let favoritesRepository = FavoritesRepository(database: app.db)
        let cartRepository = CartRepository(database: app.db)
        let userRepository = UserRepository(database: app.db, with: tokenRepository,
                                            cartRepository,
                                            favoritesRepository)
        let bannersRepository = BannersRepository(database: app.db, cache: app.caches)
        let categoryRepository = CategoryRepository(database: app.db)
        let productsRepository = ProductsRepository(database: app.db)
        let salesRepository = SalesRepository(database: app.db, cache: app.caches)
        let tsHeadlineOptionBuilder = SearchSQLRawQueryBuilder.TSHeadlineOptionBuilder()
        let sqlRawQueryBuilder: SQLRawQueryBuilderProtocol = SearchSQLRawQueryBuilder(builder: tsHeadlineOptionBuilder)
        let searchRepository = SearchRepository(database: app.db, cache: app.caches, queryBuilder: sqlRawQueryBuilder)
        let addressRepository = AddressRepository(database: app.db, cache: app.caches)
        let orderRepository = OrderRepository(database: app.db, cartRepository: cartRepository)

        try app.register(collection: UserController(with: userRepository, tokenRepository, addressRepository))
        try app.register(collection: BannersController(bannersRepository: bannersRepository))
        try app.register(collection: FavoritesController(favoritesRepository: favoritesRepository))
        try app.register(collection: CategoryController(categoryRepository: categoryRepository))
        try app.register(collection: ProductsController(productsRepository: productsRepository))
        try app.register(collection: SalesController(salesRepository: salesRepository))
        try app.register(collection: SearchController(searchRepository: searchRepository))
        try app.register(collection: CartController(cartRepository: cartRepository))
        try app.register(collection: SuggestionsController(addressRepository: addressRepository))
        try app.register(collection: OrderController(orderRepository: orderRepository))

        app.routes.print()
    }

    private init() {}

}
