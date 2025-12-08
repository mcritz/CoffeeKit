import Foundation.NSUUID

public protocol InterestGroupRepresentable: Codable {
    var id: UUID? { get }
    var name: String { get set }
    var short: String { get set }
//    var events: [EventRepresentable] { get }
    var imageURL: String? { get set }
    var isArchived: Bool? { get set }
}
