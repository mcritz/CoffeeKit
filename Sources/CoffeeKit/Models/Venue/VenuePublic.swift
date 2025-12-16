import Foundation

public struct VenuePublic: VenueRepresentable, Codable {
    public var id: UUID?
    public var name: String
    public var location: Location?
    public var url: MapURL?
    public var events: [EventPublic]?
    public var media: [MediaContentPublic]?

    public init(
        id: UUID? = nil,
        name: String,
        location: Location? = nil,
        url: MapURL? = nil,
        events: [EventPublic]? = nil,
        media: [MediaContentPublic]? = nil
    ) {
        self.id = id
        self.name = name
        self.location = location
        self.url = url
        self.events = events
        self.media = media
    }
}
