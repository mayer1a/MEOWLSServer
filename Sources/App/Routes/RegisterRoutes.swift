//
//  RegisterRoutes.swift
//
//
//  Created by Artem Mayer on 26.06.2024.
//

import Fluent
import Vapor

// MARK: - Functions

func registerRoutes(for app: Application) throws {

    app.get { req async throws in
        print("\n\n------------------------------------------------------------------------------------")
        print("IP Address [peerAddress]", req.peerAddress?.ipAddress)
        print("IP Address [remoteAddress]", req.remoteAddress?.ipAddress)
        print("Peer Address [hostname]", req.peerAddress?.hostname)
        print("Peer Address [hostname]", req.remoteAddress?.hostname)
        print("HEADERS [forwarded]", req.headers.forwarded)
        print("URL [host]", req.url.host)
        print("------------------------------------------------------------------------------------\n\n")
        
        return try await User.query(on: req.db)
            .all()
            .concurrentMap { user in
                try await user.convertToPublic(with: user.$token.get(on: req.db))
            }
    }

//    let reviewsController = ReviewsController(localStorage: storage, reviewsStorage: MockProductsReviews())
//    let cartController = CartController()
//    let productController = ProductController()

    try app.register(collection: CartController())
    try app.register(collection: CatalogController())

//    registerGETRoutes(for: app, with: storage, productController, reviewsController, cartController)
//
//    registerPOSTRoutes(for: app, with: storage, reviewsController)
    try app.register(collection: UserController())

    app.routes.print()
}
