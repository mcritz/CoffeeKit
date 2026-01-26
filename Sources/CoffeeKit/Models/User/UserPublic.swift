import Foundation

public struct UserPublic: Codable, Sendable, Hashable {
    public var id: UUID? = nil
    public var name: String
    
    public init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
