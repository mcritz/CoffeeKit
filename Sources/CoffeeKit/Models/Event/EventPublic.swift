import Foundation

public struct EventPublic: EventRepresentable, Codable {
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
}
