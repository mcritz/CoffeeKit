import Foundation

public struct UserCreate: Codable, Sendable {
    public var name: String
    public var email: String
    public var password: String
    public var confirmPassword: String
    
    public init(name: String, email: String, password: String, confirmPassword: String) {
        self.name = name
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
}

