import Foundation

public struct VenuePublic: VenueRepresentable, Codable {
    public var id: UUID?
    public var name: String
    public var location: Location?
    public var url: MapURL?
    public var events: [EventPublic]?
    public var media: [MediaContentPublic]?
}
