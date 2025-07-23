import Foundation

public struct FavoriteVideoMapper {
    
    /// FavoriteVideoエンティティをFavoriteVideoDtoに変換する
    /// - Parameter entity: 変換元のFavoriteVideoエンティティ
    /// - Returns: 変換後のFavoriteVideoDto
    public static func toDto(from entity: FavoriteVideo) -> FavoriteVideoDto {
        return FavoriteVideoDto(
            videoId: entity.videoId,
            title: entity.title,
            thumbnailUrl: entity.thumbnailUrl,
            createdAt: entity.createdAt
        )
    }
    
    /// FavoriteVideoDtoをFavoriteVideoエンティティに変換する
    /// - Parameter dto: 変換元のFavoriteVideoDto
    /// - Returns: 変換後のFavoriteVideoエンティティ
    public static func toEntity(from dto: FavoriteVideoDto) -> FavoriteVideo {
        return FavoriteVideo(
            videoId: dto.videoId,
            title: dto.title,
            thumbnailUrl: dto.thumbnailUrl,
            createdAt: dto.createdAt
        )
    }
} 