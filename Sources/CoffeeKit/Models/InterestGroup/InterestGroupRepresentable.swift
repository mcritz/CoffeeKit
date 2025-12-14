import Foundation

public protocol InterestGroupRepresentable: Codable {
    var id: UUID? { get }
    var name: String { get set }
    var short: String { get set }
    var events: [EventPublic]? { get }
    var imageURL: String? { get set }
    var isArchived: Bool? { get set }
}

extension InterestGroupRepresentable {
    public func toPublic() -> InterestGroupPublic {
        .init(
            id: id,
            name: name,
            short: short,
            events: events,
            imageURL: imageURL,
            isArchived: isArchived
        )
    }
}
