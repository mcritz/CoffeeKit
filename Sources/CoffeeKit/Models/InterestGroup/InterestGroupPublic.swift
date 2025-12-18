import Foundation

public struct InterestGroupPublic: InterestGroupRepresentable, Codable, Identifiable, Equatable {
    public var id: UUID?
    public var name: String
    public var short: String
    public var events: [EventPublic]?
    public var imageURL: String?
    public var isArchived: Bool?

    public init(
        id: UUID? = nil,
        name: String,
        short: String,
        events: [EventPublic]? = nil,
        imageURL: String? = nil,
        isArchived: Bool? = nil
    ) {
        self.id = id
        self.name = name
        self.short = short
        self.events = events
        self.imageURL = imageURL
        self.isArchived = isArchived
    }

    public static func == (lhs: InterestGroupPublic, rhs: InterestGroupPublic) -> Bool {
        let eventsEqual: Bool = {
            switch (lhs.events, rhs.events) {
            case (nil, nil): return true
            case let (le?, re?):
                guard le.count == re.count else { return false }
                return zip(le, re).allSatisfy { $0.id == $1.id }
            default: return false
            }
        }()
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.short == rhs.short
        && eventsEqual
        && lhs.imageURL == rhs.imageURL
        && lhs.isArchived == rhs.isArchived
    }
}
