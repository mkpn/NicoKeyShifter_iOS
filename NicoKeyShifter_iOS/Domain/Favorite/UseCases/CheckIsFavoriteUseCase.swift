import Foundation
import Factory

public extension Container {
    var checkIsFavoriteUseCase: Factory<CheckIsFavoriteUseCase & Sendable> {
        self {
            CheckIsFavoriteUseCaseImpl(favoriteVideoRepository: self.favoriteVideoRepository())
        }
    }
}

public protocol CheckIsFavoriteUseCase {
    func invoke(videoId: String) async -> Bool
}

public final class CheckIsFavoriteUseCaseImpl: CheckIsFavoriteUseCase {
    private let favoriteVideoRepository: FavoriteVideoRepository
    
    public init(favoriteVideoRepository: FavoriteVideoRepository) {
        self.favoriteVideoRepository = favoriteVideoRepository
    }
    
    public func invoke(videoId: String) async -> Bool {
        return await favoriteVideoRepository.isFavorite(videoId)
    }
}
