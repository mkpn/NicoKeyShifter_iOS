import Foundation
import Factory
import Data

public extension Container {
    var getFavoriteVideoByIdUseCase: Factory<GetFavoriteVideoByIdUseCase & Sendable> {
        self {
            GetFavoriteVideoByIdUseCaseImpl()
        }
    }
}

public protocol GetFavoriteVideoByIdUseCase {
    func invoke(videoId: String) async -> FavoriteVideoDomainModel?
}

public final class GetFavoriteVideoByIdUseCaseImpl: GetFavoriteVideoByIdUseCase {
    private let favoriteVideoRepository = Container.shared.favoriteVideoRepository()
    
    public func invoke(videoId: String) async -> FavoriteVideoDomainModel? {
        guard let favoriteVideo = await favoriteVideoRepository.getById(videoId) else {
            return nil
        }
        return FavoriteVideoMapper.toDomainModel(favoriteVideo: favoriteVideo)
    }
}
