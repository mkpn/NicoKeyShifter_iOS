import Foundation
import Factory
import Data

public extension Container {
    var removeFavoriteVideoUseCase: Factory<RemoveFavoriteVideoUseCase & Sendable> {
        self {
            RemoveFavoriteVideoUseCaseImpl()
        }
    }
}

public protocol RemoveFavoriteVideoUseCase {
    func invoke(favoriteVideo: FavoriteVideoDomainModel) async
}

public final class RemoveFavoriteVideoUseCaseImpl: RemoveFavoriteVideoUseCase {
    private let favoriteVideoRepository = Container.shared.favoriteVideoRepository()
    
    public func invoke(favoriteVideo: FavoriteVideoDomainModel) async {
        await favoriteVideoRepository.delete(
            .init(videoId: favoriteVideo.videoId,
                  title: favoriteVideo.title,
                  thumbnailUrl: favoriteVideo.thumbnailUrl)
        )
    }
}
