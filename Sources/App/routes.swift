import Fluent
import Vapor

// MARK: - Functions

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    let regController = SignUpController()
    app.post("signup", use: regController.signUp)

    let signInController = SignInController()
    app.post("signin", use: signInController.signIn)

    let logoutController = LogoutController()
    app.post("logout", use: logoutController.logout)

    let editProfileController = EditProfileController()
    app.post("edit-profile", use: editProfileController.edit)

    let getCatalogController = GetCatalogController()
    app.post("catalog", use: getCatalogController.get)

    let getProductController = GetProductController()
    app.post("product", use: getProductController.get)

    let getReviewsController = GetReviewsController()
    app.get("reviews", use: getReviewsController.get)

    let addReviewController = AddReviewController()
    app.post("add-review", use: addReviewController.addReview)

    let approveReviewController = ApproveReviewController()
    app.post("approve-review", use: approveReviewController.approveReview)

    let removeReviewController = RemoveReviewController()
    app.post("remove-review", use: removeReviewController.removeReview)

    try app.register(collection: TodoController())
}
