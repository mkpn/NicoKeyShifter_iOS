import Foundation
import Factory

public extension Container {
    var getAllFavoriteVideosUseCase: Factory<GetAllFavoriteVideosUseCase & Sendable> {
        self {
            GetAllFavoriteVideosUseCaseImpl(favoriteVideoRepository: self.favoriteVideoRepository())
        }
    }
}

public protocol GetAllFavoriteVideosUseCase {
    func invoke() async -> [FavoriteVideoDomainModel]
}

public final class GetAllFavoriteVideosUseCaseImpl: GetAllFavoriteVideosUseCase {
    private let favoriteVideoRepository: FavoriteVideoRepository
    
    public init(favoriteVideoRepository: FavoriteVideoRepository) {
        self.favoriteVideoRepository = favoriteVideoRepository
    }
    
    public func invoke() async -> [FavoriteVideoDomainModel] {
        let favoriteVideos = await favoriteVideoRepository.getAll()
        return favoriteVideos.map { favoriteVideo in
            FavoriteVideoMapper.toDomainModel(favoriteVideo: favoriteVideo)
        }
    }
}
