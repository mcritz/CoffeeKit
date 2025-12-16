import Foundation

public struct Location: Codable, Sendable {
    public let title: String?

    // https://developer.apple.com/maps/place-id-lookup/
    public let applePlaceID: String?
    public let address: String?
    public let latitude, longitude: Double?

    public init(
        title: String? = nil,
        applePlaceID: String? = nil,
        address: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil
    ) {
        self.title = title
        self.applePlaceID = applePlaceID
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Location: Equatable {
    public static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.applePlaceID == rhs.applePlaceID
        || lhs.address == rhs.address
        || (lhs.latitude, lhs.longitude) == (rhs.latitude, rhs.longitude)
    }
}

extension Location {
    public var mapLocation: String {
        var queryItems: [URLQueryItem] = []

        if let applePlaceID {
            queryItems.append(.init(name: "place-id", value: applePlaceID))
        }
        if let address = address {
            queryItems.append(.init(name: "address", value: address))
        }
        if let title {
            queryItems.append(.init(name: "name", value: title))
        }
        if let lat = latitude,
            let lon = longitude
        {
            queryItems.append(.init(name: "coordinate", value: "\(lat),\(lon)"))
        }

        let baseURL = URL(string: "https://maps.apple.com/place")!
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return "—"
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url?.absoluteString ?? "??"
    }
}
