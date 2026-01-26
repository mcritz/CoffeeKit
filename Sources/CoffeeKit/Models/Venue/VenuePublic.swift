import Foundation

public struct VenuePublic: VenueRepresentable, Codable, Identifiable, Equatable, Hashable, Sendable {
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

    public static func == (lhs: VenuePublic, rhs: VenuePublic) -> Bool {
        // Compare scalar properties and referential equality via ids for related collections
        let eventsEqual: Bool = {
            switch (lhs.events, rhs.events) {
            case (nil, nil): return true
            case let (le?, re?):
                guard le.count == re.count else { return false }
                // Compare by id only to avoid deep recursion
                return zip(le, re).allSatisfy { $0.id == $1.id }
            default: return false
            }
        }()
        let mediaEqual: Bool = {
            switch (lhs.media, rhs.media) {
            case (nil, nil): return true
            case let (lm?, rm?):
                guard lm.count == rm.count else { return false }
                return zip(lm, rm).allSatisfy { $0.id == $1.id }
            default: return false
            }
        }()
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.location == rhs.location
        && lhs.url == rhs.url
        && eventsEqual
        && mediaEqual
    }
}
