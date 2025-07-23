import Foundation
import SwiftData

public struct FavoriteVideoDto: Sendable {
    public var videoId: String
    public var title: String
    public var thumbnailUrl: String
    public var createdAt: Date
    
    public init(videoId: String, title: String, thumbnailUrl: String, createdAt: Date = Date()) {
        self.videoId = videoId
        self.title = title
        self.thumbnailUrl = thumbnailUrl
        self.createdAt = createdAt
    }
}
