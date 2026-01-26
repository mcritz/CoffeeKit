import Foundation

public struct MediaContentPublic: MediaContentRepresentable, Identifiable, Equatable, Hashable, Sendable {
    public var id: UUID?
    public var filename: String
    public var rawFilename: String
    public var mimeType: String
    public var contentLength: Int

    public init(id: UUID? = nil, filename: String, rawFilename: String, mimeType: String, contentLength: Int) {
        self.id = id
        self.filename = filename
        self.rawFilename = rawFilename
        self.mimeType = mimeType
        self.contentLength = contentLength
    }

    public static func == (lhs: MediaContentPublic, rhs: MediaContentPublic) -> Bool {
        return lhs.id == rhs.id
        && lhs.filename == rhs.filename
        && lhs.rawFilename == rhs.rawFilename
        && lhs.mimeType == rhs.mimeType
        && lhs.contentLength == rhs.contentLength
    }
}
