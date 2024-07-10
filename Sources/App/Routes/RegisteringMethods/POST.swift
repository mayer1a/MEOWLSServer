//
//  POST.swift
//  
//
//  Created by Artem Mayer on 19.06.2024.
//

import Vapor

// MARK: - POS Routes

/// Register all POST routes
/// + signup
/// + signin
/// + logout
/// + edit-profile
/// + add-review
/// + approve-review
/// + remove-review
/// + add-product
/// + remove-product
/// + edit-product
/// + pay-basket
func registerPOSTRoutes(for app: Application,
                        with storage: LocalStorage,
                        _ reviewsController: ReviewsController) {

    app.post("signup", use: SignUpController(localStorage: storage).signUp)

    app.post("signin", use: SignInController(localStorage: storage).signIn)

    app.post("logout", use: LogoutController(localStorage: storage).logout)

    app.post("edit-profile", use: ProfileController(localStorage: storage).edit)

    app.post("add-review", use: reviewsController.addReview)
    app.post("approve-review", use: reviewsController.approveReview)
    app.post("remove-review", use: reviewsController.removeReview)

}
