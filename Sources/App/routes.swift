import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    let controller = AuthController()
    app.post("register", use: controller.register)

    try app.register(collection: TodoController())
}
