//
//  Authenticator.swift
//  
//
//  Created by Artem Mayer on 29.06.2024.
//

import Vapor

/// Helper for creating authentication middleware using the Custom Token authorization header.
public protocol CustomTokenAuthenticator: RequestAuthenticator {

    func authenticate(token: CustomTokenAuthorization, for request: Request) -> EventLoopFuture<Void>

}

extension CustomTokenAuthenticator {

    public func authenticate(request: Request) -> EventLoopFuture<Void> {
        
        guard let customTokenAuthorization = request.headers.customTokenAuthorization else {
            return request.eventLoop.makeSucceededFuture(())
        }
        return self.authenticate(token: customTokenAuthorization, for: request)
    }
    
}
