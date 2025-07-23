import Foundation
import Factory
import Data

public extension Container {
    var addFavoriteVideoUseCase: Factory<AddFavoriteVideoUseCase & Sendable> {
        self {
            AddFavoriteVideoUseCaseImpl()
        }
    }
}

public protocol AddFavoriteVideoUseCase {
    func invoke(favoriteVideo: FavoriteVideoDomainModel) async
}

public final class AddFavoriteVideoUseCaseImpl: AddFavoriteVideoUseCase {
    private let favoriteVideoRepository = Container.shared.favoriteVideoRepository()
    
    public func invoke(favoriteVideo: FavoriteVideoDomainModel) async {
        await favoriteVideoRepository.add(
            .init(videoId: favoriteVideo.videoId,
                  title: favoriteVideo.title,
                  thumbnailUrl: favoriteVideo.thumbnailUrl)
        )
    }
}
