import Fluent
import Vapor

// MARK: - Functions

func routes(_ app: Application) throws {
    let localStorage = LocalStorage()
    let reviewsStorage = MockProductsReviews()

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

    let logoutController = LogoutController(localStorage: localStorage)
    app.post("logout", use: logoutController.logout)

    let editProfileController = EditProfileController(localStorage: localStorage)
    app.post("edit-profile", use: editProfileController.edit)

    let getCatalogController = GetCatalogController()
    app.get("catalog", use: getCatalogController.get)

    let getProductController = GetProductController()
    app.get("product", use: getProductController.get)

    let reviewsController = ReviewsController(localStorage: localStorage, reviewsStorage: reviewsStorage)
    app.get("reviews", use: reviewsController.get)
    app.post("add-review", use: reviewsController.addReview)
    app.post("approve-review", use: reviewsController.approveReview)
    app.post("remove-review", use: reviewsController.removeReview)

    let basketController = BasketController()
    app.post("add-product", use: basketController.addProduct)
    app.post("remove-product", use: basketController.removeProduct)
    app.post("edit-product", use: basketController.editProductQuantity)
    app.post("pay-basket", use: basketController.pay)
    app.get("basket", use: basketController.getUserBasket)

    try app.register(collection: TodoController())
}
