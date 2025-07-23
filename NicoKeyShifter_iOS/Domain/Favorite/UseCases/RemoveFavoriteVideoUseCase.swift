import Foundation
import Factory
import Data

public extension Container {
    var removeFavoriteVideoUseCase: Factory<RemoveFavoriteVideoUseCase & Sendable> {
        self {
            RemoveFavoriteVideoUseCaseImpl(favoriteVideoRepository: self.favoriteVideoRepository())
        }
    }
}

public protocol RemoveFavoriteVideoUseCase {
    func invoke(favoriteVideo: FavoriteVideoDomainModel) async
}

public final class RemoveFavoriteVideoUseCaseImpl: RemoveFavoriteVideoUseCase {
    private let favoriteVideoRepository: FavoriteVideoRepository
    
    public init(favoriteVideoRepository: FavoriteVideoRepository) {
        self.favoriteVideoRepository = favoriteVideoRepository
    }
    
    public func invoke(favoriteVideo: FavoriteVideoDomainModel) async {
        let entity = FavoriteVideoMapper.toEntity(domainModel: favoriteVideo)
        await favoriteVideoRepository.delete(entity)
    }
}
