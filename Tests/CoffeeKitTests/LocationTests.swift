import Testing
import Foundation
@testable import CoffeeKit

@Suite("Location Tests")
struct LocationTests {
    
    @Test("Location with all fields populated")
    func testLocationWithAllFields() async throws {
        let location = Location(
            title: "Coffee Shop",
            applePlaceID: "I1234567890ABCDEF",
            address: "123 Main St, San Francisco, CA 94102",
            latitude: 37.7749,
            longitude: -122.4194
        )
        
        #expect(location.title == "Coffee Shop")
        #expect(location.applePlaceID == "I1234567890ABCDEF")
        #expect(location.address == "123 Main St, San Francisco, CA 94102")
        #expect(location.latitude == 37.7749)
        #expect(location.longitude == -122.4194)
    }
    
    @Test("Location with nil fields")
    func testLocationWithNilFields() async throws {
        let location = Location(
            title: nil,
            applePlaceID: nil,
            address: nil,
            latitude: nil,
            longitude: nil
        )
        
        #expect(location.title == nil)
        #expect(location.applePlaceID == nil)
        #expect(location.address == nil)
        #expect(location.latitude == nil)
        #expect(location.longitude == nil)
    }
    
    @Test("Map URL with all query parameters")
    func testMapLocationWithAllParameters() async throws {
        let location = Location(
            title: "Coffee Shop",
            applePlaceID: "I1234567890ABCDEF",
            address: "123 Main St",
            latitude: 37.7749,
            longitude: -122.4194
        )
        
        let mapURL = location.mapLocation
        
        #expect(mapURL.contains("maps.apple.com/place"))
        #expect(mapURL.contains("place-id=I1234567890ABCDEF"))
        #expect(mapURL.contains("address=123%20Main%20St"))
        #expect(mapURL.contains("name=Coffee%20Shop"))
        #expect(mapURL.contains("coordinate=37.7749,-122.4194"))
    }
    
    @Test("Map URL with only Apple Place ID")
    func testMapLocationWithOnlyPlaceID() async throws {
        let location = Location(
            title: nil,
            applePlaceID: "I1234567890ABCDEF",
            address: nil,
            latitude: nil,
            longitude: nil
        )
        
        let mapURL = location.mapLocation
        
        #expect(mapURL.contains("place-id=I1234567890ABCDEF"))
        #expect(!mapURL.contains("address="))
        #expect(!mapURL.contains("name="))
        #expect(!mapURL.contains("coordinate="))
    }
    
    @Test("Map URL with only coordinates")
    func testMapLocationWithOnlyCoordinates() async throws {
        let location = Location(
            title: nil,
            applePlaceID: nil,
            address: nil,
            latitude: 37.7749,
            longitude: -122.4194
        )
        
        let mapURL = location.mapLocation
        
        #expect(mapURL.contains("coordinate=37.7749,-122.4194"))
        #expect(!mapURL.contains("place-id="))
        #expect(!mapURL.contains("address="))
        #expect(!mapURL.contains("name="))
    }
    
    @Test("Map URL with only address")
    func testMapLocationWithOnlyAddress() async throws {
        let location = Location(
            title: nil,
            applePlaceID: nil,
            address: "123 Main St, San Francisco, CA",
            latitude: nil,
            longitude: nil
        )
        
        let mapURL = location.mapLocation
        
        #expect(mapURL.contains("address=123%20Main%20St"))
        #expect(mapURL.contains("San%20Francisco"))
    }
    
    @Test("Map URL with only title")
    func testMapLocationWithOnlyTitle() async throws {
        let location = Location(
            title: "Coffee Shop",
            applePlaceID: nil,
            address: nil,
            latitude: nil,
            longitude: nil
        )
        
        let mapURL = location.mapLocation
        
        #expect(mapURL.contains("name=Coffee%20Shop"))
    }
    
    @Test("Map URL with no data returns fallback")
    func testMapLocationWithNoData() async throws {
        let location = Location(
            title: nil,
            applePlaceID: nil,
            address: nil,
            latitude: nil,
            longitude: nil
        )
        
        let mapURL = location.mapLocation
        
        // Returns base URL with empty query string when no query items are present
        #expect(mapURL == "https://maps.apple.com/place?")
    }
    
    @Test("Map URL with special characters in address")
    func testMapLocationWithSpecialCharactersInAddress() async throws {
        let location = Location(
            title: nil,
            applePlaceID: nil,
            address: "123 Main St #5, San Francisco & Oakland",
            latitude: nil,
            longitude: nil
        )
        
        let mapURL = location.mapLocation
        
        // Should be URL encoded
        #expect(mapURL.contains("%20")) // Space
        #expect(mapURL.contains("%23") || mapURL.contains("#")) // Hash
        #expect(mapURL.contains("%26") || mapURL.contains("&")) // Ampersand
    }
    
    @Test("Map URL with special characters in title")
    func testMapLocationWithSpecialCharactersInTitle() async throws {
        let location = Location(
            title: "Joe's Coffee & Tea",
            applePlaceID: nil,
            address: nil,
            latitude: nil,
            longitude: nil
        )
        
        let mapURL = location.mapLocation
        
        // Should be URL encoded
        #expect(mapURL.contains("Joe") || mapURL.contains("Joe%27s"))
        #expect(mapURL.contains("%26") || mapURL.contains("&"))
    }
    
    @Test("Map URL with negative coordinates")
    func testMapLocationWithNegativeCoordinates() async throws {
        let location = Location(
            title: nil,
            applePlaceID: nil,
            address: nil,
            latitude: -33.8688,
            longitude: 151.2093
        )
        
        let mapURL = location.mapLocation
        
        #expect(mapURL.contains("coordinate=-33.8688,151.2093"))
    }
    
    @Test("Map URL with zero coordinates")
    func testMapLocationWithZeroCoordinates() async throws {
        let location = Location(
            title: nil,
            applePlaceID: nil,
            address: nil,
            latitude: 0.0,
            longitude: 0.0
        )
        
        let mapURL = location.mapLocation
        
        #expect(mapURL.contains("coordinate=0.0,0.0"))
    }
    
    @Test("Map URL base URL is correct")
    func testMapLocationBaseURL() async throws {
        let location = Location(
            title: "Test",
            applePlaceID: nil,
            address: nil,
            latitude: nil,
            longitude: nil
        )
        
        let mapURL = location.mapLocation
        
        #expect(mapURL.hasPrefix("https://maps.apple.com/place"))
    }
    
    @Test("Location is Codable")
    func testLocationCodable() async throws {
        let location = Location(
            title: "Coffee Shop",
            applePlaceID: "I1234567890ABCDEF",
            address: "123 Main St",
            latitude: 37.7749,
            longitude: -122.4194
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(location)
        let decoded = try decoder.decode(Location.self, from: data)
        
        #expect(decoded.title == location.title)
        #expect(decoded.applePlaceID == location.applePlaceID)
        #expect(decoded.address == location.address)
        #expect(decoded.latitude == location.latitude)
        #expect(decoded.longitude == location.longitude)
    }
    
    @Test("Location is Sendable")
    func testLocationSendable() async throws {
        let location = Location(
            title: "Coffee Shop",
            applePlaceID: "I1234567890ABCDEF",
            address: "123 Main St",
            latitude: 37.7749,
            longitude: -122.4194
        )
        
        // This should compile without warnings because Location conforms to Sendable
        Task {
            let _ = location
        }
    }
    
    @Test("Map URL with partial coordinates returns fallback")
    func testMapLocationWithOnlyLatitude() async throws {
        let location = Location(
            title: nil,
            applePlaceID: nil,
            address: nil,
            latitude: 37.7749,
            longitude: nil
        )
        
        let mapURL = location.mapLocation
        
        // Should not include coordinate parameter if both lat and lon aren't present
        #expect(!mapURL.contains("coordinate="))
    }
}
