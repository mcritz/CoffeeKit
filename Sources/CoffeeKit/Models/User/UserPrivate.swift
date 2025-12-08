import Foundation

public struct UserPrivate: Codable, Sendable {
    public var id: UUID?
    public var name: String
    public var email: String
    
    public init(id: UUID? = nil, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
}

