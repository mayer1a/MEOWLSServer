//
//  GET.swift
//  
//
//  Created by Artem Mayer on 19.06.2024.
//

import Vapor

// MARK: - GET Routes

/// Register all GET Routes
/// + {Root}
/// + hello
/// + catalog
/// + product
/// + reviews
/// + basket
func registerGETRoutes(for app: Application,
                       with storage: LocalStorage,
                       _ productController: ProductController,
                       _ reviewsController: ReviewsController,
                       _ cartController: CartController) {

    let protected = app.grouped(UserAuthenticator())
    protected.get("hello", ":x") { req -> String in
        guard
            let str = req.parameters.get("x", as: String.self),
            let headersAuth = req.headers["Auth"].first,
            let byteBuffer = req.body.data,
            let cbk = try? JSONDecoder().decode(BK.self, from: byteBuffer)
        else {
            throw Abort(.badRequest)
        }

        print("[CONTENT]:", /*try?*/ req.content/*.get(String.self, at: "Auth")*/)
        print("[QUERY]:", try req.query.get(String.self, at: "p"))
        print("\n\n")

        return "Hello, world!\n[HEADERS: Auth] \(headersAuth)\n[PARAMETERS: X] \(str)\n[BODY: custom-body-key] \(cbk)"
    }

    app.get("product", use: productController.get)

    app.get("reviews", use: reviewsController.get)

}


struct UserAuthenticator: RequestAuthenticator {

    func authenticate(request: Request) -> EventLoopFuture<Void> {
        print("[HEADERS {AUTH}]:", request.headers["Authorization"])
//        let a = try? request.auth.require(UserT.self) else {

        guard
            let token = request.headers["Authorization"].first?.split(separator: " ").last,
            token == "bWF5ZXIxYXJ0OjEyMzQ1Njc4OTA="
        else {
            return request.eventLoop.makeFailedFuture(Abort(.unauthorized))
        }
        print("[AUTH token]:", request.headers["Authorization"])
//        request.auth.login(UserT(name: "Vapor"))
        return request.eventLoop.makeSucceededFuture(())
    }

}
struct UserT: Authenticatable {
    var Authorization: String
}
struct BK: Decodable {
    let customBodyKey: String

    enum CodingKeys: String, CodingKey {
        case customBodyKey = "custom-body-key"
    }
}
