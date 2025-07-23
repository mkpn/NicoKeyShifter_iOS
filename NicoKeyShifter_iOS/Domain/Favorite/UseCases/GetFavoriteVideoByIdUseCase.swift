import Foundation
import Factory

public extension Container {
    var getFavoriteVideoByIdUseCase: Factory<GetFavoriteVideoByIdUseCase & Sendable> {
        self {
            GetFavoriteVideoByIdUseCaseImpl(favoriteVideoRepository: self.favoriteVideoRepository())
        }
    }
}

public protocol GetFavoriteVideoByIdUseCase {
    func invoke(videoId: String) async -> FavoriteVideoDomainModel?
}

public final class GetFavoriteVideoByIdUseCaseImpl: GetFavoriteVideoByIdUseCase {
    private let favoriteVideoRepository: FavoriteVideoRepository
    
    public init(favoriteVideoRepository: FavoriteVideoRepository) {
        self.favoriteVideoRepository = favoriteVideoRepository
    }
    
    public func invoke(videoId: String) async -> FavoriteVideoDomainModel? {
        guard let favoriteVideo = await favoriteVideoRepository.getById(videoId) else {
            return nil
        }
        return FavoriteVideoMapper.toDomainModel(favoriteVideo: favoriteVideo)
    }
}
