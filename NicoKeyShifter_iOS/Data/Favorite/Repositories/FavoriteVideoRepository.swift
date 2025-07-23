import Foundation
import Factory
import SwiftData

public extension Container {
    var favoriteVideoRepository: Factory<FavoriteVideoRepository & Sendable> {
        self {
            FavoriteVideoRepositoryImpl()
        }
    }
}

public protocol FavoriteVideoRepository {
    func getAll() async -> [FavoriteVideo]
    func getById(_ videoId: String) async -> FavoriteVideo?
    func add(_ favoriteVideo: FavoriteVideo) async
    func delete(_ favoriteVideo: FavoriteVideo) async
    func deleteById(_ videoId: String) async
    func isFavorite(_ videoId: String) async -> Bool
}

public final class FavoriteVideoRepositoryImpl: FavoriteVideoRepository {
    @Injected(\.favoriteVideoDataSource) private var dataSource
    
    public init(){}
    
    public func getAll() async -> [FavoriteVideo] {
        await dataSource.getAll()
    }
    
    public func getById(_ videoId: String) async -> FavoriteVideo? {
        await dataSource.getById(videoId)
    }
    
    public func add(_ favoriteVideo: FavoriteVideo) async {
        await dataSource.add(favoriteVideo)
    }
    
    public func delete(_ favoriteVideo: FavoriteVideo) async {
        await dataSource.delete(favoriteVideo)
    }
    
    public func deleteById(_ videoId: String) async {
        await dataSource.deleteById(videoId)
    }
    
    public func isFavorite(_ videoId: String) async -> Bool {
        await dataSource.isFavorite(videoId)
    }
}
