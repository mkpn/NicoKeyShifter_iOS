import Foundation
import Factory
import Data

public extension Container {
    var removeFavoriteVideoByIdUseCase: Factory<RemoveFavoriteVideoByIdUseCase & Sendable> {
        self {
            RemoveFavoriteVideoByIdUseCaseImpl()
        }
    }
}

public protocol RemoveFavoriteVideoByIdUseCase {
    func invoke(videoId: String) async
}

public final class RemoveFavoriteVideoByIdUseCaseImpl: RemoveFavoriteVideoByIdUseCase {
    private let favoriteVideoRepository = Container.shared.favoriteVideoRepository()

    public func invoke(videoId: String) async {
        await favoriteVideoRepository.deleteById(videoId)
    }
}
