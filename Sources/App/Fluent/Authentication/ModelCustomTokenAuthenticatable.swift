//
//  ModelCustomTokenAuthenticatable.swift
//
//
//  Created by Artem Mayer on 29.06.2024.
//

import Vapor
import Fluent

public protocol ModelCustomTokenAuthenticatable: Model, Authenticatable {

    associatedtype User: Model & Authenticatable

    static var valueKey: KeyPath<Self, Field<String>> { get }
    static var userKey: KeyPath<Self, Parent<User>> { get }

    var isValid: Bool { get }
    var canRefreshable: Bool { get }

}

extension ModelCustomTokenAuthenticatable {

    public static func authenticator() -> any Authenticator {
        ModelCustomTokenAuthenticator<Self>()
    }

    var _$value: Field<String> {
        self[keyPath: Self.valueKey]
    }

    var _$user: Parent<User> {
        self[keyPath: Self.userKey]
    }
    
}

private typealias TokenAuthenticatable = ModelCustomTokenAuthenticatable

private struct ModelCustomTokenAuthenticator<Token>: CustomTokenAuthenticator where Token: TokenAuthenticatable {

    public func authenticate(token: CustomTokenAuthorization, for request: Request) -> EventLoopFuture<Void> {
        Token.query(on: request.db)
            .filter(\._$value == token.token)
            .with(\._$user)
            .first()
            .flatMap { token -> EventLoopFuture<Void> in

                guard let token else { return request.eventLoop.makeSucceededFuture(()) }

                guard token.isValid || (token.canRefreshable && request.isRefreshRoutePath) else {
                    return request.eventLoop.makeFailedFuture(ErrorFactory.unauthorized())
                }

                request.auth.login(token)

                return token._$user.get(on: request.db).map {
                    request.auth.login($0)
                }
            }
    }

}
