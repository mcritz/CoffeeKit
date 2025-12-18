// AI Generated

import Testing
@testable import CoffeeKit

// A helper that only compiles if T conforms to Equatable & Identifiable
private func assertEquatableIdentifiable<T>(_: T.Type, file: StaticString = #file, line: UInt = #line) where T: Equatable & Identifiable {}

@Suite("Public Types Conformance")
struct PublicTypesConformanceTests {
    @Test("EventPublic, VenuePublic, MediaContentPublic, InterestGroupPublic, Location are Equatable & Identifiable")
    func testConformance() {
        assertEquatableIdentifiable(EventPublic.self)
        assertEquatableIdentifiable(VenuePublic.self)
        assertEquatableIdentifiable(MediaContentPublic.self)
        assertEquatableIdentifiable(InterestGroupPublic.self)
        assertEquatableIdentifiable(Location.self)
    }
}
