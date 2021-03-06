import Crypto
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // public routes
    let userController = UserController()
    router.post("users", use: userController.create)
    
    // basic / password auth protected routes
    let basic = router.grouped(User.basicAuthMiddleware(using: BCryptDigest()))
    basic.post("login", use: userController.login)
    
    // bearer / token auth protected routes
    let bearer = router.grouped(User.tokenAuthMiddleware())
    let todoController = TodoController()
    bearer.get("todos", use: todoController.index)
    bearer.post("todos", use: todoController.create)
    bearer.delete("todos", Todo.parameter, use: todoController.delete)

    // Views
    router.get("welcome") { req -> Future<View> in
      return try req.view().render("welcome")
    }

    router.get("whoami") { req -> Future<View> in
      let user = User(name: "Saul", email: "93sauu@gmail.com", passwordHash: ".....")
      return try req.view().render("whoami", user)
    }
}
