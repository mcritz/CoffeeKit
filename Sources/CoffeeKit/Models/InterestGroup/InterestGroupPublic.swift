import Foundation

public struct InterestGroupPublic: InterestGroupRepresentable, Codable {
    public var id: UUID?
    public var name: String
    public var short: String
    public var events: [EventPublic]?
    public var imageURL: String?
    public var isArchived: Bool?

    public init(
        id: UUID? = nil,
        name: String,
        short: String,
        events: [EventPublic]? = nil,
        imageURL: String? = nil,
        isArchived: Bool? = nil
    ) {
        self.id = id
        self.name = name
        self.short = short
        self.events = events
        self.imageURL = imageURL
        self.isArchived = isArchived
    }
}
