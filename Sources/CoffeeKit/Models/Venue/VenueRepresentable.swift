import Foundation

public protocol VenueRepresentable: Codable {
    var id: UUID? { get set }
    var name: String { get set }
    var location: Location? { get set }
    var url: MapURL? { get set }
    var events: [EventPublic]? { get set }
    var media: [MediaContentPublic]? { get set }
}

extension VenueRepresentable {
    public func toPublic() -> VenuePublic {
        .init(
            id: id,
            name: name,
            location: location,
            url: url,
            events: events,
            media: media
        )
    }
}
