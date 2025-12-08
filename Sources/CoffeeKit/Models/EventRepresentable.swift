import Foundation

public protocol EventRepresentable: Codable {
    var id: UUID? { get set }
    var name: String { get set }
//    var groupID: UUID { get set }
//    var venue: Venue { get set }
    var imageURL: ImageURL? { get set }
    var startAt: Date { get set }
    var endAt: Date { get set }
}

public enum EventCodingKeys: String, CodingKey {
    case id
    case groupID = "group_id"
    case name
    case imageURL = "image_url"
    case startAt = "start_at"
    case endAt = "end_at"
    case venue
}
