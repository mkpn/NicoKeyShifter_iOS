import Foundation
import Factory
import Data

public extension Container {
    var checkIsFavoriteUseCase: Factory<CheckIsFavoriteUseCase & Sendable> {
        self {
            CheckIsFavoriteUseCaseImpl()
        }
    }
}

public protocol CheckIsFavoriteUseCase {
    func invoke(videoId: String) async -> Bool
}

public final class CheckIsFavoriteUseCaseImpl: CheckIsFavoriteUseCase {
    private let favoriteVideoRepository = Container.shared.favoriteVideoRepository()
    
    public func invoke(videoId: String) async -> Bool {
        return await favoriteVideoRepository.isFavorite(videoId)
    }
}
