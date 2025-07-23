import Foundation
import Factory
import Data

public extension Container {
    var addFavoriteVideoUseCase: Factory<AddFavoriteVideoUseCase & Sendable> {
        self {
            AddFavoriteVideoUseCaseImpl(favoriteVideoRepository: self.favoriteVideoRepository())
        }
    }
}

public protocol AddFavoriteVideoUseCase {
    func invoke(favoriteVideo: FavoriteVideoDomainModel) async
}

public final class AddFavoriteVideoUseCaseImpl: AddFavoriteVideoUseCase {
    private let favoriteVideoRepository: FavoriteVideoRepository
    
    public init(favoriteVideoRepository: FavoriteVideoRepository) {
        self.favoriteVideoRepository = favoriteVideoRepository
    }
    
    public func invoke(favoriteVideo: FavoriteVideoDomainModel) async {
        let entity = FavoriteVideoMapper.toEntity(domainModel: favoriteVideo)
        await favoriteVideoRepository.add(entity)
    }
}
