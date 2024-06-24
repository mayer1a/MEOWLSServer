import Fluent
import Vapor

// MARK: - Functions

final class ABC: Content {
    let usersPrivate: [User]
    let usersPublic: [User.Public]
    let tokens: [Token]
    let desc: String
    init(usersPrivate: [User], usersPublic: [User.Public], tokens: [Token], desc: String) {
        self.usersPrivate = usersPrivate
        self.usersPublic = usersPublic
        self.tokens = tokens
        self.desc = desc
    }
}

func registerRoutes(for app: Application) throws {
    app.get { req async throws in
        let usersPri = try await User.query(on: req.db).all()
        var usersPub = [User.Public]()
        for user in usersPri {
//            let id = user.id
            let token = try? await Token.query(on: req.db).filter(\.$user.$id == user.requireID()).first()?.value
            usersPub.append(User.Public(id: user.id, surname: user.surname, name: user.name, patronymic: user.patronymic, birthday: user.birthday, gender: user.gender, email: user.email, phone: user.phone, token: token, credit_card: user.credit_card))
        }
        let tokens = try await Token.query(on: req.db).all()

        return ABC(usersPrivate: usersPri,
                   usersPublic: usersPub,
                   tokens: tokens,
                   desc: "MEOWLS Server running on [\(Date().description)]")
    }

    app.get("del") { req async throws in
        try await User.query(on: req.db).delete()
        try await Token.query(on: req.db).delete()

        return "SUCCESS"
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
//    try app.register(collection: TodoController())
    print("All routes:", app.routes)
}
