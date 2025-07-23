import Foundation

public enum FavoriteVideoMapper {
    public static func toDomainModel(favoriteVideo: FavoriteVideo) -> FavoriteVideoDomainModel {
        return FavoriteVideoDomainModel(
            videoId: favoriteVideo.videoId,
            title: favoriteVideo.title,
            thumbnailUrl: favoriteVideo.thumbnailUrl,
            createdAt: favoriteVideo.createdAt
        )
    }
    
    public static func toEntity(domainModel: FavoriteVideoDomainModel) -> FavoriteVideo {
        return FavoriteVideo(
            videoId: domainModel.videoId,
            title: domainModel.title,
            thumbnailUrl: domainModel.thumbnailUrl,
            createdAt: domainModel.createdAt
        )
    }
}
