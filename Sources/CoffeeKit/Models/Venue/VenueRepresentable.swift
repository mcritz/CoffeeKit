import Foundation

public protocol VenueRepresentable: Codable {
    var id: UUID? { get set }
    var name: String { get set }
    var location: Location? { get set }
    var url: MapURL? { get set }
//    var events: [EventPublic]? { get set }
//    var media: [MediaContentPublic]? { get set }
}

extension VenueRepresentable {
    public func toPublic(
        events: [EventRepresentable]? = nil,
        media: [MediaContentRepresentable]? = nil
    ) -> VenuePublic {
        let publicEvents = events?.map { $0.toPublic() }
        let publicMedia = media?.map { $0.toPublic() }
        return .init(
            id: id,
            name: name,
            location: location,
            url: url,
            events: publicEvents,
            media: publicMedia
        )
    }
}
