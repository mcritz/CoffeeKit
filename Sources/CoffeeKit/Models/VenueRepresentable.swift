import Foundation

public protocol VenueRepresentable {
    var id: UUID? { get set }
    var name: String { get set }
    var location: Location? { get set }
    var url: MapURL? { get set }
}
