import Foundation

public struct Location: Codable, Sendable, Identifiable {
    public let title: String?

    // https://developer.apple.com/maps/place-id-lookup/
    public let applePlaceID: String?
    public let address: String?
    public let latitude, longitude: Double?

    // Stable identifier preference: applePlaceID > address > coordinates > fallback
    public var id: String {
        if let applePlaceID { return "place:" + applePlaceID }
        if let address { return "addr:" + address }
        if let lat = latitude, let lon = longitude { return "coord:\(lat),\(lon)" }
        return "location:unknown"
    }

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
        if let lPlaceID = lhs.applePlaceID, let rPlaceID = rhs.applePlaceID {
            return lPlaceID == rPlaceID
        }
        if let lAddress = lhs.address, let rAddress = rhs.address {
            return lAddress == rAddress}
        let geoEqual: Bool = ((lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude))
        return geoEqual
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

