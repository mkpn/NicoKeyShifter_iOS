import Foundation
import Factory
import Data

public extension Container {
    var removeFavoriteVideoByIdUseCase: Factory<RemoveFavoriteVideoByIdUseCase & Sendable> {
        self {
            RemoveFavoriteVideoByIdUseCaseImpl(favoriteVideoRepository: self.favoriteVideoRepository())
        }
    }
}

public protocol RemoveFavoriteVideoByIdUseCase {
    func invoke(videoId: String) async
}

public final class RemoveFavoriteVideoByIdUseCaseImpl: RemoveFavoriteVideoByIdUseCase {
    private let favoriteVideoRepository: FavoriteVideoRepository
    
    public init(favoriteVideoRepository: FavoriteVideoRepository) {
        self.favoriteVideoRepository = favoriteVideoRepository
    }
    
    public func invoke(videoId: String) async {
        await favoriteVideoRepository.deleteById(videoId)
    }
}
