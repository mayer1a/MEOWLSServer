import Fluent
import Vapor

// MARK: - Functions

func routes(_ app: Application) throws {
    let localStorage = LocalStorage()

    app.get { req async in
        "GBShop Server running on [\(Date().description)]"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    let regController = SignUpController(localStorage: localStorage)
    app.post("signup", use: regController.signUp)

    let signInController = SignInController(localStorage: localStorage)
    app.post("signin", use: signInController.signIn)

    let logoutController = LogoutController()
    app.post("logout", use: logoutController.logout)

    let editProfileController = EditProfileController(localStorage: localStorage)
    app.post("edit-profile", use: editProfileController.edit)

    let getCatalogController = GetCatalogController()
    app.get("catalog", use: getCatalogController.get)

    let getProductController = GetProductController()
    app.get("product", use: getProductController.get)

    let getReviewsController = GetReviewsController()
    app.get("reviews", use: getReviewsController.get)

    let addReviewController = AddReviewController()
    app.post("add-review", use: addReviewController.addReview)

    let approveReviewController = ApproveReviewController()
    app.post("approve-review", use: approveReviewController.approveReview)

    let removeReviewController = RemoveReviewController()
    app.post("remove-review", use: removeReviewController.removeReview)

    let basketController = BasketController()
    app.post("add-product", use: basketController.addProduct)
    app.post("remove-product", use: basketController.removeProduct)
    app.post("edit-product", use: basketController.editProductQuantity)
    app.post("pay-basket", use: basketController.pay)

    try app.register(collection: TodoController())
}
