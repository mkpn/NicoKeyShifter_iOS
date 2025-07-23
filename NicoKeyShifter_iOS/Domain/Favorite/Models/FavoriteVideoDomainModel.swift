import Foundation

public struct FavoriteVideoDomainModel {
    public let videoId: String
    public let title: String
    public let thumbnailUrl: String
    public let createdAt: Date
    
    public init(videoId: String, title: String, thumbnailUrl: String, createdAt: Date) {
        self.videoId = videoId
        self.title = title
        self.thumbnailUrl = thumbnailUrl
        self.createdAt = createdAt
    }
    
    public static func ofDefault() -> FavoriteVideoDomainModel {
        return FavoriteVideoDomainModel(
            videoId: "sm12345678",
            title: "サンプルお気に入り動画",
            thumbnailUrl: "",
            createdAt: Date()
        )
    }
}
