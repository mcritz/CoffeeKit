import Foundation

public struct EventPublic: EventRepresentable, Codable {
    public var id: UUID?
    public var name: String
    public var groupID: UUID?
    public var venue: VenuePublic?
    public var imageURL: ImageURL?
    public var startAt: Date
    public var endAt: Date
}
