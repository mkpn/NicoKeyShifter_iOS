import Foundation
import Factory
import Data

public extension Container {
    var getAllFavoriteVideosUseCase: Factory<GetAllFavoriteVideosUseCase & Sendable> {
        self {
            GetAllFavoriteVideosUseCaseImpl()
        }
    }
}

public protocol GetAllFavoriteVideosUseCase {
    func invoke() async -> [FavoriteVideoDomainModel]
}

public final class GetAllFavoriteVideosUseCaseImpl: GetAllFavoriteVideosUseCase {
    private let favoriteVideoRepository = Container.shared.favoriteVideoRepository()

    public func invoke() async -> [FavoriteVideoDomainModel] {
        let favoriteVideos = await favoriteVideoRepository.getAll()
        return favoriteVideos.map { favoriteVideo in
            FavoriteVideoMapper.toDomainModel(favoriteVideo: favoriteVideo)
        }
    }
}
