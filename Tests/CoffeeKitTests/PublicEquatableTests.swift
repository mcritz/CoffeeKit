import Testing
import Foundation
@testable import CoffeeKit

@Suite("Public Types Equatable Tests")
struct PublicEquatableTests {

    // MARK: - EventPublic
    @Test("EventPublic equality and inequality")
    func testEventPublicEquatable() async throws {
        let venueID = UUID()
        let venue1 = VenuePublic(id: venueID, name: "Cafe A")
        let venue2 = VenuePublic(id: venueID, name: "Cafe A")
        let start = Date(timeIntervalSince1970: 1_700_000_000)
        let end = Date(timeIntervalSince1970: 1_700_010_000)
        let e1 = EventPublic(id: UUID(), name: "Tasting", groupID: UUID(), venue: venue1, imageURL: nil, startAt: start, endAt: end)
        let e2 = EventPublic(id: e1.id, name: e1.name, groupID: e1.groupID, venue: venue2, imageURL: nil, startAt: start, endAt: end)
        #expect(e1 == e2)

        // Change a scalar field -> not equal
        let e3 = EventPublic(id: e1.id, name: "Different", groupID: e1.groupID, venue: venue2, imageURL: nil, startAt: start, endAt: end)
        #expect(e1 != e3)

        // Change venue id -> not equal (we compare venue by id)
        let differentVenue = VenuePublic(id: UUID(), name: "Cafe B")
        let e4 = EventPublic(id: e1.id, name: e1.name, groupID: e1.groupID, venue: differentVenue, imageURL: nil, startAt: start, endAt: end)
        #expect(e1 != e4)
    }

    // MARK: - MediaContentPublic
    @Test("MediaContentPublic equality and inequality")
    func testMediaContentPublicEquatable() async throws {
        let id = UUID()
        let m1 = MediaContentPublic(id: id, filename: "a.jpg", rawFilename: "a", mimeType: "image/jpeg", contentLength: 123)
        let m2 = MediaContentPublic(id: id, filename: "a.jpg", rawFilename: "a", mimeType: "image/jpeg", contentLength: 123)
        #expect(m1 == m2)

        let m3 = MediaContentPublic(id: id, filename: "b.jpg", rawFilename: "a", mimeType: "image/jpeg", contentLength: 123)
        #expect(m1 != m3)
    }

    // MARK: - VenuePublic
    @Test("VenuePublic equality and inequality (events/media compared by id)")
    func testVenuePublicEquatable() async throws {
        let venueID = UUID()
        let eID1 = UUID()
        let eID2 = UUID()
        let mediaID1 = UUID()
        let mediaID2 = UUID()

        let e1 = EventPublic(id: eID1, name: "Roast", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        let e2 = EventPublic(id: eID2, name: "Cup", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        let m1 = MediaContentPublic(id: mediaID1, filename: "a.jpg", rawFilename: "a", mimeType: "image/jpeg", contentLength: 100)
        let m2 = MediaContentPublic(id: mediaID2, filename: "b.jpg", rawFilename: "b", mimeType: "image/jpeg", contentLength: 200)

        let v1 = VenuePublic(id: venueID, name: "Cafe", location: nil, url: nil, events: [e1, e2], media: [m1, m2])
        let v2 = VenuePublic(id: venueID, name: "Cafe", location: nil, url: nil, events: [
            EventPublic(id: eID1, name: "X", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date()),
            EventPublic(id: eID2, name: "Y", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        ], media: [
            MediaContentPublic(id: mediaID1, filename: "x.jpg", rawFilename: "x", mimeType: "image/jpeg", contentLength: 10),
            MediaContentPublic(id: mediaID2, filename: "y.jpg", rawFilename: "y", mimeType: "image/jpeg", contentLength: 20)
        ])
        #expect(v1 == v2) // compared by ids for events/media

        // Change the order of events -> inequality because comparison is positional
        let v3 = VenuePublic(id: venueID, name: "Cafe", location: nil, url: nil, events: [e2, e1], media: [m1, m2])
        #expect(v1 != v3)

        // Different media id -> inequality
        let v4 = VenuePublic(id: venueID, name: "Cafe", location: nil, url: nil, events: [e1, e2], media: [m1, MediaContentPublic(id: UUID(), filename: "b.jpg", rawFilename: "b", mimeType: "image/jpeg", contentLength: 200)])
        #expect(v1 != v4)

        // nil vs non-nil collections -> inequality
        let v5 = VenuePublic(id: venueID, name: "Cafe", location: nil, url: nil, events: nil, media: nil)
        #expect(v1 != v5)
    }

    // MARK: - InterestGroupPublic
    @Test("InterestGroupPublic equality and inequality (events compared by id)")
    func testInterestGroupPublicEquatable() async throws {
        let gid = UUID()
        let eID = UUID()
        let g1 = InterestGroupPublic(id: gid, name: "Espresso", short: "ESP", events: [
            EventPublic(id: eID, name: "Meetup", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        ], imageURL: "https://example.com/img.png", isArchived: false)
        let g2 = InterestGroupPublic(id: gid, name: "Espresso", short: "ESP", events: [
            EventPublic(id: eID, name: "Different Name OK", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        ], imageURL: "https://example.com/img.png", isArchived: false)
        #expect(g1 == g2)

        // Different event id -> inequality
        let g3 = InterestGroupPublic(id: gid, name: "Espresso", short: "ESP", events: [
            EventPublic(id: UUID(), name: "Meetup", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        ], imageURL: "https://example.com/img.png", isArchived: false)
        #expect(g1 != g3)

        // Change scalar field -> inequality
        let g4 = InterestGroupPublic(id: gid, name: "Latte", short: "ESP", events: g1.events, imageURL: g1.imageURL, isArchived: g1.isArchived)
        #expect(g1 != g4)
    }

    // MARK: - Location (quick sanity check; detailed tests exist separately)
    @Test("Location quick equatable check")
    func testLocationEquatableQuick() async throws {
        let l1 = Location(title: nil, applePlaceID: "PID", address: nil, latitude: nil, longitude: nil)
        let l2 = Location(title: "Name", applePlaceID: "PID", address: "Addr", latitude: 1, longitude: 2)
        #expect(l1 == l2) // same place id -> equal per custom logic

        let l3 = Location(title: nil, applePlaceID: nil, address: nil, latitude: 1, longitude: 2)
        let l4 = Location(title: nil, applePlaceID: nil, address: nil, latitude: 1, longitude: 3)
        #expect(l3 != l4)
    }
}
