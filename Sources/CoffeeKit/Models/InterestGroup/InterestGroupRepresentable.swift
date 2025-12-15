import Foundation

public protocol InterestGroupRepresentable: Codable {
    var id: UUID { get }
    var name: String { get set }
    var short: String { get set }
    var imageURL: String? { get set }
    var isArchived: Bool? { get set }
}

extension InterestGroupRepresentable {
    public func toPublic(events: [EventRepresentable]) -> InterestGroupPublic {
        let publicEvents = events.map { $0.toPublic(groupID: self.id, venue: nil) }
        return InterestGroupPublic(
            id: id,
            name: name,
            short: short,
            events: publicEvents,
            imageURL: imageURL,
            isArchived: isArchived
        )
    }
}
