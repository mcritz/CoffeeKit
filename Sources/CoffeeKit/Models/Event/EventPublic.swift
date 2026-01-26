import Foundation

public struct EventPublic: EventRepresentable, Codable, Identifiable, Hashable, Equatable, Sendable {
    public var id: UUID?
    public var name: String
    public var groupID: UUID?
    public var venue: VenuePublic?
    public var imageURL: ImageURL?
    public var startAt: Date
    public var endAt: Date

    public init(
        id: UUID? = nil,
        name: String,
        groupID: UUID? = nil,
        venue: VenuePublic? = nil,
        imageURL: ImageURL? = nil,
        startAt: Date,
        endAt: Date
    ) {
        self.id = id
        self.name = name
        self.groupID = groupID
        self.venue = venue
        self.imageURL = imageURL
        self.startAt = startAt
        self.endAt = endAt
    }

    public static func == (lhs: EventPublic, rhs: EventPublic) -> Bool {
        // Compare scalar properties directly and avoid deep recursion by comparing venue by id only
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.groupID == rhs.groupID
        && lhs.imageURL == rhs.imageURL
        && lhs.startAt == rhs.startAt
        && lhs.endAt == rhs.endAt
        && lhs.venue?.id == rhs.venue?.id
    }
}

