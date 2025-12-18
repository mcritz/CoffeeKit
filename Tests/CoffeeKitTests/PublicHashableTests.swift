// AI Generated

import Testing
import Foundation
@testable import CoffeeKit

@Suite("Public Types Hashable Tests")
struct PublicHashableTests {

    // Helper to compute a stable hash value via Hasher for comparison in tests
    private func hashValue<T: Hashable>(of value: T) -> Int {
        var hasher = Hasher()
        value.hash(into: &hasher)
        return hasher.finalize()
    }

    @Test("UserPublic Hashable: equal instances have same hash and Set deduplicates")
    func testUserPublicHashable() async throws {
        let id = UUID()
        let a = UserPublic(id: id, name: "Jane")
        let b = UserPublic(id: id, name: "Jane")
        #expect(a == b)
        #expect(hashValue(of: a) == hashValue(of: b))

        var set = Set<UserPublic>()
        set.insert(a)
        set.insert(b)
        #expect(set.count == 1)

        let c = UserPublic(id: id, name: "Different")
        #expect(a != c) // per Equatable for UserPublic (if any) or structural inequality
        #expect(set.contains(a))
        #expect(!set.contains(c))
    }

    @Test("MediaContentPublic Hashable: equal instances have same hash and Set deduplicates")
    func testMediaContentPublicHashable() async throws {
        let id = UUID()
        let a = MediaContentPublic(id: id, filename: "a.jpg", rawFilename: "a", mimeType: "image/jpeg", contentLength: 10)
        let b = MediaContentPublic(id: id, filename: "a.jpg", rawFilename: "a", mimeType: "image/jpeg", contentLength: 10)
        #expect(a == b)
        #expect(hashValue(of: a) == hashValue(of: b))

        var set = Set<MediaContentPublic>()
        set.insert(a)
        set.insert(b)
        #expect(set.count == 1)

        let c = MediaContentPublic(id: id, filename: "b.jpg", rawFilename: "b", mimeType: "image/jpeg", contentLength: 20)
        #expect(a != c)
        #expect(set.contains(a))
        #expect(!set.contains(c))
    }

    @Test("EventPublic Hashable: equal instances have same hash and Set deduplicates")
    func testEventPublicHashable() async throws {
        let id = UUID()
        let start = Date(timeIntervalSince1970: 1_700_000_000)
        let end = Date(timeIntervalSince1970: 1_700_010_000)
        let a = EventPublic(id: id, name: "Tasting", groupID: UUID(), venue: nil, imageURL: nil, startAt: start, endAt: end)
        let b = EventPublic(id: id, name: "Tasting", groupID: a.groupID, venue: nil, imageURL: nil, startAt: start, endAt: end)
        #expect(a == b)
        #expect(hashValue(of: a) == hashValue(of: b))

        var set = Set<EventPublic>()
        set.insert(a)
        set.insert(b)
        #expect(set.count == 1)

        let c = EventPublic(id: id, name: "Different", groupID: a.groupID, venue: nil, imageURL: nil, startAt: start, endAt: end)
        #expect(a != c)
        #expect(set.contains(a))
        #expect(!set.contains(c))
    }

    @Test("VenuePublic Hashable: equal instances have same hash and Set deduplicates")
    func testVenuePublicHashable() async throws {
        let vid = UUID()
        let eID1 = UUID()
        let eID2 = UUID()
        let mID1 = UUID()
        let mID2 = UUID()
        let events1 = [
            EventPublic(id: eID1, name: "A", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date()),
            EventPublic(id: eID2, name: "B", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        ]
        let media1 = [
            MediaContentPublic(id: mID1, filename: "a.jpg", rawFilename: "a", mimeType: "image/jpeg", contentLength: 1),
            MediaContentPublic(id: mID2, filename: "b.jpg", rawFilename: "b", mimeType: "image/jpeg", contentLength: 2)
        ]
        let a = VenuePublic(id: vid, name: "Cafe", location: nil, url: nil, events: events1, media: media1)
        let b = VenuePublic(id: vid, name: "Cafe", location: nil, url: nil, events: [
            EventPublic(id: eID1, name: "X", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date()),
            EventPublic(id: eID2, name: "Y", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        ], media: [
            MediaContentPublic(id: mID1, filename: "x.jpg", rawFilename: "x", mimeType: "image/jpeg", contentLength: 10),
            MediaContentPublic(id: mID2, filename: "y.jpg", rawFilename: "y", mimeType: "image/jpeg", contentLength: 20)
        ])
        #expect(a == b)

        var set = Set<VenuePublic>()
        set.insert(a)
        set.insert(b)
        #expect(set.count == 1)

        // Change order of events -> inequality per Equatable
        let c = VenuePublic(id: vid, name: "Cafe", location: nil, url: nil, events: events1.reversed(), media: media1)
        #expect(a != c)
        #expect(set.contains(a))
        #expect(!set.contains(c))
    }

    @Test("InterestGroupPublic Hashable: equal instances have same hash and Set deduplicates")
    func testInterestGroupPublicHashable() async throws {
        let gid = UUID()
        let eID = UUID()
        let events = [EventPublic(id: eID, name: "Meetup", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())]
        let a = InterestGroupPublic(id: gid, name: "Espresso", short: "ESP", events: events, imageURL: "https://example.com", isArchived: false)
        let b = InterestGroupPublic(id: gid, name: "Espresso", short: "ESP", events: [
            EventPublic(id: eID, name: "Different OK", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        ], imageURL: "https://example.com", isArchived: false)
        #expect(a == b)

        var set = Set<InterestGroupPublic>()
        set.insert(a)
        set.insert(b)
        #expect(set.count == 1)

        let c = InterestGroupPublic(id: gid, name: "Latte", short: "ESP", events: events, imageURL: a.imageURL, isArchived: a.isArchived)
        #expect(a != c)
        #expect(set.contains(a))
        #expect(!set.contains(c))
    }
}
