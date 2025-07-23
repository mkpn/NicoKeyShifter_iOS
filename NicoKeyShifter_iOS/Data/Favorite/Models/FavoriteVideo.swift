import Foundation
import SwiftData

@Model
public final class FavoriteVideo {
    var videoId: String
    var title: String
    var thumbnailUrl: String
    var createdAt: Date
    
    init(videoId: String, title: String, thumbnailUrl: String, createdAt: Date = Date()) {
        self.videoId = videoId
        self.title = title
        self.thumbnailUrl = thumbnailUrl
        self.createdAt = createdAt
    }
}
