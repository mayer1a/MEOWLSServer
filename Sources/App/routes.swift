import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    let regController = SignUpController()
    app.post("signup", use: regController.signUp)

    try app.register(collection: TodoController())
}
