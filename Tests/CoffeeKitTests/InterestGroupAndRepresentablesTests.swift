// AI Generated

import Testing
import Foundation
@testable import CoffeeKit

// MARK: - Stubs
private struct EventStub: EventRepresentable, Codable {
    var id: UUID?
    var name: String
    var groupID: UUID?
    var venue: VenuePublic?
    var imageURL: ImageURL?
    var startAt: Date
    var endAt: Date
}

private struct VenueStub: VenueRepresentable, Codable {
    var id: UUID?
    var name: String
    var location: Location?
    var url: MapURL?
    var events: [EventPublic]?
    var media: [MediaContentPublic]?
}

private struct MediaContentStub: MediaContentRepresentable, Codable {
    var id: UUID?
    var filename: String
    var rawFilename: String
    var mimeType: String
    var contentLength: Int
}

private struct InterestGroupStub: InterestGroupRepresentable, Codable {
    var id: UUID?
    var name: String
    var short: String
    var events: [EventPublic]?
    var imageURL: String?
    var isArchived: Bool?
}

@Suite("toPublic() Mapping Tests")
struct ToPublicMappingTests {
    @Test("EventRepresentable.toPublic maps all fields")
    func testEventToPublic() async throws {
        let venue = VenuePublic(id: UUID(), name: "Cafe", location: nil, url: nil, events: nil, media: nil)
        let image: ImageURL? = nil
        let id = UUID()
        let groupID = UUID()
        let start = Date(timeIntervalSince1970: 1_700_000_000)
        let end = Date(timeIntervalSince1970: 1_700_010_000)
        let event = EventStub(id: id, name: "Tasting", groupID: groupID, venue: venue, imageURL: image, startAt: start, endAt: end)

        let pub = event.toPublic(groupID: groupID, venue: venue)
        #expect(pub.id == id)
        #expect(pub.name == "Tasting")
        #expect(pub.groupID == groupID)
        #expect(pub.venue?.id == venue.id)
        #expect(pub.imageURL == image)
        #expect(pub.startAt == start)
        #expect(pub.endAt == end)
    }

    @Test("VenueRepresentable.toPublic maps all fields")
    func testVenueToPublic() async throws {
        let e1 = EventPublic(id: UUID(), name: "Roast", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        let media = [MediaContentPublic(id: UUID(), filename: "a.jpg", rawFilename: "a", mimeType: "image/jpeg", contentLength: 123)]
        let venue = VenueStub(id: UUID(), name: "Cafe", location: Location(title: "Main"), url: nil, events: [e1], media: media)

        let pub = venue.toPublic(events: [e1], media: media)
        #expect(pub.id == venue.id)
        #expect(pub.name == venue.name)
        #expect(pub.location?.title == venue.location?.title)
        #expect(pub.url == venue.url)
        #expect(pub.events?.count == venue.events?.count)
        #expect(pub.media?.count == venue.media?.count)
    }

    @Test("MediaContentRepresentable.toPublic maps all fields")
    func testMediaToPublic() async throws {
        let stub = MediaContentStub(id: UUID(), filename: "file.png", rawFilename: "file", mimeType: "image/png", contentLength: 456)
        let pub = stub.toPublic()
        #expect(pub.id == stub.id)
        #expect(pub.filename == stub.filename)
        #expect(pub.rawFilename == stub.rawFilename)
        #expect(pub.mimeType == stub.mimeType)
        #expect(pub.contentLength == stub.contentLength)
    }

    @Test("InterestGroupRepresentable.toPublic maps all fields")
    func testInterestGroupToPublic() async throws {
        let event = EventPublic(id: UUID(), name: "Meetup", groupID: nil, venue: nil, imageURL: nil, startAt: Date(), endAt: Date())
        let stub = InterestGroupStub(id: UUID(), name: "Espresso", short: "ESP", events: [event], imageURL: "https://example.com/img.png", isArchived: false)
        let pub = stub.toPublic(events: [event])
        #expect(pub.id == stub.id)
        #expect(pub.name == stub.name)
        #expect(pub.short == stub.short)
        #expect(pub.events?.count == stub.events?.count)
        #expect(pub.imageURL == stub.imageURL)
        #expect(pub.isArchived == stub.isArchived)
    }
}
