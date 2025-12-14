import Foundation

public protocol MediaContentRepresentable: Codable {
    var id: UUID? { get }
    var filename: String { get }
    var rawFilename: String { get }
    var mimeType: String { get }
    var contentLength: Int { get }
}

extension MediaContentRepresentable {
    public func toPublic() -> MediaContentPublic {
        .init(
            id: id,
            filename: filename,
            rawFilename: rawFilename,
            mimeType: mimeType,
            contentLength: contentLength
        )
    }
}
