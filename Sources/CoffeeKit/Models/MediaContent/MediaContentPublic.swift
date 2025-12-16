import Foundation

public struct MediaContentPublic: MediaContentRepresentable {
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
}
